Script works in two modes:
    1. "--mini": if you want to import *_Mini.tsv provided datasets
    2. "--default": if you want to import full (not mini)

Script imports data from two places:
    1. To scan scv/tsv files with data in "datasets" folder
        and import it (if files was found)
    2. To scan scv/tsv files with data in "../datasets" folder
        (that is the provided datasets) and import:
        - *_Mini.tsv: if mode is "--mini"
        - *.tsv: if mode is "--default"
