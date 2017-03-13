from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy

ext_modules = [Extension("lorenz96_solver", ["lorenz96_solver.pyx"])]

setup(
  name = 'Lorenz96 solve routine',
  cmdclass = {'build_ext': build_ext},
  include_dirs = [numpy.get_include()],
  ext_modules = ext_modules
)

