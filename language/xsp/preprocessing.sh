mkdir -p xsp_experiment_run/examples

python -m data_preprocessing.convert_to_examples \
--dataset_name=spider \
--input_filepath=data/spider/ \
--splits=dev \
--output_filepath=xsp_experiment_run/examples/spider_dev.json \
--generate_sql=False \
--tokenizer_vocabulary=assets/input_bert_vocabulary.txt