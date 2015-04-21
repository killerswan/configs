'''
'''

import logging
import os
import re
import sys
import unittest
from   winenv import self_is_elevated, WinEnv, KEY_PATH

def newpath(raw):
   return os.path.expandvars(os.path.normpath(raw))

def do_add(dirpath):
   '''
   Use WinEnv to add a directory to the %path%.
   '''
   if not os.path.isdir(newpath(dirpath)):
      logging.critical('Directory does not exist: ' + dirpath)
      return False

   if not self_is_elevated():
      logging.critical('You need to be elevated/admin...')
      return False

   env = WinEnv()
   env.add(KEY_PATH, dirpath)
   env.announce()
   return True

def do_read_list():
   '''
   Use WinEnv to query all the dirs in the %path%.
   '''
   env = WinEnv()
   return env.read_list(KEY_PATH)

def do_remove(dirpath):
   '''
   Use WinEnv to remove an item from the %path%.
   '''
   env = WinEnv()
   return env.remove(KEY_PATH, dirpath)

def is_valid_path(dirpath):
   logging.debug('checking dir: ' + dirpath)

   if '\\' == dirpath[-1]:
      logging.critical('should not end with a slash')
      return False

   if ';' in dirpath:
      logging.critical('should not have a semicolon')
      return False

   if '/' in dirpath:
      logging.critical('should not have a fwd slash')
      return False

   if '/' in dirpath:
      logging.critical('should not have a fwd slash')
      return False

   if not os.path.isdir(newpath(dirpath)):
      logging.critical('should be a real directory: %s' % newpath(dirpath))
      return False

   if re.search(r'%[Aa]pp[Dd]ata%', dirpath):
      logging.critical('should not contain user envvars (like %appdata%)')
      return False

   return True

class FixMyPath(unittest.TestCase):
   _multiprocess_can_split_ = False

   def assert_valid_path(self, dir):
      self.assertTrue(is_valid_path(dir))

   def add(self, dir):
      self.assert_valid_path(dir)
      return do_add(dir)

   def test_setup_my_path(self):
      '''
      NOTE: I'm calling newpath() around %AppData%, below, to avoid problems.

      This script sets the system-level %Path% envvar.
      User-level envvars cannot always be expanded when called inside system-level envars,
      so referencing %AppData% directly leads to pain: an admin console will then
      have an expanded %AppData%/npm, but a user console will have it non-functional and un-expanded.

      There are some bugs related to this sort of thing...
      (1) http://support.microsoft.com/kb/329308 and
      (2) http://social.technet.microsoft.com/Forums/windows/en-US/6cb3e0f5-f401-4c73-a756-666565a4d762/expanding-environment-variables-in-windows-7-and-missing-properties-under-right-click-computer-
      '''

      map(self.add, [
            '%SystemRoot%\\system32',
            '%SystemRoot%',

            newpath('C:/Perl64/site/bin'),
            newpath('C:/Perl64/bin'),

            newpath('C:/Python27'),
            newpath('C:/Python27/Scripts'),

            newpath('C:/users/kevin.cantu/AppData/Local/Julia-0.3.1/bin'),

            newpath('C:/Program Files (x86)/Microsoft F#/v4.0'),

            newpath('C:/Program Files/nodejs'),
            newpath('C:/Users/kevin.cantu/AppData/Roaming/npm'),

            newpath('C:/Program Files/7-Zip'),

            newpath('C:/Program Files/Mercurial'),

            newpath('C:/Program Files (x86)/git/cmd'),
            newpath('C:/Program Files (x86)/git/bin'),
            newpath('C:/Program Files/ConEmu'),

            # visual studio ...
 
            newpath('C:/MinGW64/bin'),
            newpath('C:/MinGW/bin'),
            newpath('C:/MinGW/msys/1.0/bin'),

            #'C:/Program Files (x86)/Haskell Platform/2013.2.0.0/lib/extralibs/bin',
            #'C:/Program Files (x86)/Haskell Platform/2013.2.0.0/bin',
            #'%AppData%\\cabal\\bin',

            newpath('C:/Program Files (x86)/KDiff3'),
            newpath('C:/Program Files (x86)/PostgreSQL/9.4/bin'),

            newpath('C:/Program Files/Java/jdk1.8.0_40/bin'),
         ])

   def test_everything_in_path_exists(self):
      def check(dir):
         self.assert_valid_path(dir)

      map(check, do_read_list())

   def test_wash_path(self):
      for dir in do_read_list():
         if not is_valid_path(dir):
            logging.critical('removing directory from path: ' + dir)
            do_remove(dir)
               

if __name__ == '__main__':
   logging.basicConfig(level=logging.DEBUG)
   unittest.main() 

