#!/usr/bin/env python
#
# List all 'exported' attribute values of components
# (Activity/Service/BroadcastReceiver) in AndroidManifest.xml
#
# Usage:
#   $ ./android-check-export.py AndroidManifest.xml
#
import os.path
import sys
from xml.etree import ElementTree

NAME_SPACE = '{http://schemas.android.com/apk/res/android}'

def usage():
    script = os.path.basename(sys.argv[0])
    print('Usage: python {} AndroidManifest.xml'.format(script))
    sys.exit(1)

def dump_node(node):
    name = node.attrib[NAME_SPACE + 'name']
    exported = node.attrib.get(NAME_SPACE + 'exported', '?')
    print('    * {} [exported={}]'.format(name, exported))

def dump_nodes(label, nodes):
    print(label)
    for node in nodes:
        dump_node(node)
    print()

if __name__ == '__main__':
    if len(sys.argv) < 2:
        usage()
    manifest = sys.argv[1]
    root = ElementTree.parse(manifest).getroot()
    dump_nodes('Activities:', root.findall('./application/activity'))
    dump_nodes('Services:', root.findall('./application/service'))
    dump_nodes('Receivers:', root.findall('./application/receiver'))

