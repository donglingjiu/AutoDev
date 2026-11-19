#!/usr/bin/env python3
# OPT-002: autodev contract referential integrity
import json, os, sys
AD = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
errs = []
c = json.load(open(os.path.join(AD, 'contract.json'), encoding='utf-8'))
if set(c.get('modes', {}).keys()) != {'MISS', 'NEED_UPDATE', 'UP_TO_DATE', 'BUILDER_UNAVAILABLE'}:
    errs.append('modes keys incomplete: %s' % sorted(c.get('modes', {}).keys()))
if len(c.get('steps', [])) != 5: errs.append('steps expected 5, got %d' % len(c.get('steps', [])))
if not os.path.isfile(os.path.join(AD, c.get('detectScript', ''))): errs.append('detectScript missing')
for t in c.get('templates', []):
    if not os.path.isfile(os.path.join(AD, t)): errs.append('template missing: %s' % t)
if errs:
    print('contract.json INVALID:'); [print('  ' + e) for e in errs]; sys.exit(1)
print('contract.json OK: 4 modes, 5 steps, detectScript + templates resolved')
