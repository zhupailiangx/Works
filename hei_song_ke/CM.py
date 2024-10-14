
from PIL import Image
import glob
import torch
import pickle
import zipfile
from IPython.display import display
from IPython.display import Image as IPImage
import os
from tqdm.autonotebook import tqdm
from sentence_transformers import SentenceTransformer, util
# Here we load the multilingual CLIP model. Note, this model can only encode text.
# If you need embeddings for images, you must load the 'clip-ViT-B-32' model
img_folder = 'photos/'
def model_prepared():
    model = SentenceTransformer('clip-ViT-B-32-multilingual-v1')
    return model

# Next, we get about 25k images from Unsplash

def data_prepared():

    if not os.path.exists(img_folder) or len(os.listdir(img_folder)) == 0:
        os.makedirs(img_folder, exist_ok=True)

        photo_filename = 'unsplash-25k-photos.zip'
        if not os.path.exists(photo_filename):  # Download dataset if does not exist
            util.http_get('http://sbert.net/datasets/' + photo_filename, photo_filename)

        # Extract all images
        with zipfile.ZipFile(photo_filename, 'r') as zf:
            for member in tqdm(zf.infolist(), desc='Extracting'):
                zf.extract(member, img_folder)

# Now, we need to compute the embeddings
# To speed things up, we destribute pre-computed embeddings
# Otherwise you can also encode the images yourself.
# To encode an image, you can use the following code:
# from PIL import Image
# img_emb = model.encode(Image.open(filepath))

def img_text_emb():
    use_precomputed_embeddings = False

    if use_precomputed_embeddings:
        emb_filename = 'unsplash-25k-photos-embeddings.pkl'
        if not os.path.exists(emb_filename):  # Download dataset if does not exist
            util.http_get('http://sbert.net/datasets/' + emb_filename, emb_filename)

        with open(emb_filename, 'rb') as fIn:
            img_names, img_emb = pickle.load(fIn)
        print("Images:", len(img_names))
    else:
        # For embedding images, we need the non-multilingual CLIP model
        img_model = SentenceTransformer('clip-ViT-B-32')

        img_names = list(glob.glob('photos/*.jpg'))
        print("Images:", len(img_names))
        img_emb = img_model.encode([Image.open(filepath) for filepath in img_names], batch_size=128, convert_to_tensor=True,
                                   show_progress_bar=True,device='cuda')
    return img_emb,img_names


# Next, we define a search function.
def search(query,model,img_emb,img_names, k=3 ):
    # First, we encode the query (which can either be an image or a text string)
    query_emb = model.encode([query], convert_to_tensor=True, show_progress_bar=False,device='cuda')

    # Then, we use the util.semantic_search function, which computes the cosine-similarity
    # between the query embedding and all image embeddings.
    # It then returns the top_k highest ranked images, which we output
    hits = util.semantic_search(query_emb, img_emb, top_k=k)[0]

    print("Query:")
    display(query)
    for hit in hits:
        print(img_names[hit['corpus_id']])
        display(IPImage(os.path.join(img_folder, img_names[hit['corpus_id']]), width=200))


if __name__=="__main__":
    model = model_prepared()
    data_prepared()
    img_emb,img_names =img_text_emb()
    search("两只狗在雪地上跑",model,img_emb,img_names,k=1)
