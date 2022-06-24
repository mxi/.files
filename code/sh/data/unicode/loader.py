#!/usr/bin/python
import requests
import sys

import bs4


def loadrange(begin, end, targets):
    """
    :param begin
        Required integer: begin <= end

    :param end
        Required integer: begin <= end

    :param targets
        A list of streams to write the queried information to.
    """
    with requests.Session() as sess:
        while begin <= end:
            # converts for ex. int 0x12ab -> "12AB"
            char = chr(begin)
            upoint = str(hex(begin)[2:]).upper()
            lpoint = upoint.lower()

            # load and parse page
            page = sess.get(f"https://unicode-table.com/en/{upoint}/")
            parsed = bs4.BeautifulSoup(page.text, "html.parser")
            el_title = parsed.find("h1", attrs={"id": "symbol-title"})
            el_subtitle = el_title.next_sibling.next_sibling

            # print useful information
            title = el_title.text[2:].lower()
            subtitle = el_subtitle.text.lower()
            row = f"{char}\t{title}\t{subtitle}\t{lpoint}\n"

            for target in targets:
                target.write(row)

            # also write to
            begin += 1


if __name__ == "__main__":
    # create output targets
    targets = [ sys.stdout ]
    for file in sys.argv[1:]:
        targets.append(open(file, "w"))

    # query unicode ranges
    for i, line in enumerate(sys.stdin):
        # load range pair
        range_ = line.split()
        if len(range_) < 2:
            sys.stderr.write(f"{i+1}: invalid pair.\n")
            continue

        # parse range
        try:
            begin = int(range_[0], base=16)
            end = int(range_[1], base=16)
        except ValueError:
            sys.stderr.write(f"{i+1}: invalid hexadecimal pair.\n")
            continue

        # ensure correct range
        if end < begin:
            sys.stderr.write(f"{i+1}: invalid range (reversed).\n")
            continue
        
        # load range from unicode-table.com
        loadrange(begin, end, targets)

    # close output targets
    for target in targets[1:]:
        target.close()
