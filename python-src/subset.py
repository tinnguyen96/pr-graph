from numpy.random import default_rng
import io

import conllu

if __name__ == "__main__":
    f_name = "../data/langs/english/english_ptb_train.conll"

    file = open(f_name, "r", encoding="latin")
    all_data = file.read()
    sentences = conllu.parse(all_data)
    file.close()

    # some descriptive stats
    n_sentences = len(sentences)
    print("Number of sentences = %d" %n_sentences)

    n_tokens = 0
    for i in range(len(sentences)):
        n_tokens += len(sentences[i])
    print("Number of tokens = %d" %n_tokens)

    # subset a small portion
    rng = default_rng(42)
    s_indices = rng.choice(n_sentences, size=int(n_sentences/10), replace=False)
    newf_name = "../data/langs/english/english_small_ptb_train.conll"
    new_file = open(newf_name, "w", encoding="latin")
    n_tokens_written = 0
    for i in s_indices:
        n_tokens_written += len(sentences[i])
        to_str = sentences[i].serialize()
        new_file.write(to_str)
    new_file.close()
    print("Number of sentences subsetted = %d" %len(s_indices))
    print("Number of tokens written = %d" %n_tokens_written)
