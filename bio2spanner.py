import argparse as ap
import json, random

from dataprocess.bio2spannerformat import keep_spanPred_data


def main(args):
  random.seed(37)
  print(f"Reading IOB2 file: {args.src}")
  data = keep_spanPred_data(args.dataname, args.src, args.column, args.delimiter)

  print(data[:10])
  print()
  if args.split != 'test':
    random.shuffle(data)
    print(data[:10])

  with open(args.dst, 'w') as fp:
    json.dump(data, fp, sort_keys=True, ensure_ascii=False, indent=2)


if __name__ == "__main__":
  p = ap.ArgumentParser()
  p.add_argument('--src', required=True)
  p.add_argument('--dst', required=True)
  p.add_argument('--dataname', default='X')
  p.add_argument('--column', default=-1)
  p.add_argument('--delimiter', default='\t')
  p.add_argument('--split', default='train')
  main(p.parse_args())
