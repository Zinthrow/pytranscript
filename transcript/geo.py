
import GEOparse
from Bio.Affy import CelFile

def download_geo_data(geo_accession):
    """
    Download GEO data for the given accession number.
    """
    # Fetch the GEO dataset
    geo_data = GEOparse.get_GEO(geo_accession)

    # Print a summary of the dataset
    print(f"Title: {geo_data.metadata['title'][0]}")
    print(f"Summary: {geo_data.metadata['summary'][0]}")
    print(f"Overall Design: {geo_data.metadata['overall_design'][0]}")

    # Download all samples (This can be a lot of data!)
    for gsm in geo_data.gsms:
        print(f"Downloading {gsm}...")
        geo_data.gsms[gsm].download_supplementary_files()

def read_cel_file(path):
    with open(path, "r") as file: 
        cdf = CelFile.read(file)
    # Extract the relevant data from cdf
    # For example, let's assume you want to extract intensity values
    intensities = cdf.intensities  # This is just an example, adjust according to your data structure
    return intensities
