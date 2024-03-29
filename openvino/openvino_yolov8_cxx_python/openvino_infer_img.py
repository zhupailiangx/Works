import sys

from openvino.runtime import Core
import numpy as np
import cv2, time
import yaml
from ultralytics.utils import ROOT, yaml_load
#from ultralytics.yolo.utils.checks import check_yaml
from ultralytics.utils.checks import check_yaml

MODEL_NAME = "yolov8n"
CLASSES = yaml_load(check_yaml('coco128.yaml'))['names']
colors = np.random.uniform(0, 255, size=(len(CLASSES), 3))


def draw_bounding_box(img, class_id, confidence, x, y, x_plus_w, y_plus_h):
    label = f'{CLASSES[class_id]} ({confidence:.2f})'
    color = colors[class_id]
    cv2.rectangle(img, (x, y), (x_plus_w, y_plus_h), color, 2)
    cv2.putText(img, label, (x - 10, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.5, color, 2)


# 实例化Core对象
core = Core()
# 载入并编译模型
net = core.compile_model(f'{MODEL_NAME}.onnx', device_name="CPU")
# 获得模型输出节点
output_node = net.outputs[0]  # yolov8n只有一个输出节点
ir = net.create_infer_request()


#while True:
tota_fps=0
for i in range(100):
    start = time.time()
    original_image: np.ndarray = cv2.imread("zidane.jpg")
    [height, width, _] = original_image.shape
    length = max((height, width))
    image = np.zeros((length, length, 3), np.uint8)
    image[0:height, 0:width] = original_image
    scale = length / 640
    blob = cv2.dnn.blobFromImage(image, scalefactor=1 / 255, size=(640, 640), swapRB=True)


    outputs = ir.infer(blob)[output_node]


    outputs = np.array([cv2.transpose(outputs[0])])
    rows = outputs.shape[1]

    boxes = []
    scores = []
    class_ids = []

    for i in range(rows):
        classes_scores = outputs[0][i][4:]
        (minScore, maxScore, minClassLoc, (x, maxClassIndex)) = cv2.minMaxLoc(classes_scores)
        if maxScore >= 0.25:
            box = [
                outputs[0][i][0] - (0.5 * outputs[0][i][2]), outputs[0][i][1] - (0.5 * outputs[0][i][3]),
                outputs[0][i][2], outputs[0][i][3]]
            boxes.append(box)
            scores.append(maxScore)
            class_ids.append(maxClassIndex)

    result_boxes = cv2.dnn.NMSBoxes(boxes, scores, 0.25, 0.5, 0.5)

    detections = []
    for i in range(len(result_boxes)):
        index = result_boxes[i]
        box = boxes[index]
        detection = {
            'class_id': class_ids[index],
            'class_name': CLASSES[class_ids[index]],
            'confidence': scores[index],
            'box': box,
            'scale': scale}
        detections.append(detection)
        draw_bounding_box(original_image, class_ids[index], scores[index], round(box[0] * scale), round(box[1] * scale),
                          round((box[0] + box[2]) * scale), round((box[1] + box[3]) * scale))
    end = time.time()
    # show FPS
    fps = (1 / (end - start))
    #print("fps:",fps)
    tota_fps += fps
    fps_label = "FPS: %.2f" % fps
    cv2.putText(original_image, fps_label, (10, 25), cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 0, 255), 2)

    cv2.imshow('YOLOv8 OpenVINO Inference Python Demo', original_image)
    # wait key for ending

    if cv2.waitKey(1) > -1:
        print("finished by user")
        #cap.release()
        cv2.destroyAllWindows()
        #break
print("Mean FPS:",tota_fps/100)



