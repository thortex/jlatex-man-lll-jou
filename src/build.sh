#!/bin/sh -x
uplatex jou

uplatex jou

upmendex -s sind.ist -d jou.dic -o jou.ind jou.idx

uplatex jou

upmendex -s sgls.ist -d jou.dic -o jou.gls jou.glo

uplatex jou 

(while egrep "may have changed" jou.log; \
           do uplatex jou; done)

uplatex jou

dvipdfmx -o jou.pdf jou.dvi

