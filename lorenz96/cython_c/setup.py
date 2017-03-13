from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy

ext_modules = [Extension(
    name="lorenz96_wrapper",
    sources=["lorenz96_wrapper.pyx"],
    extra_objects=["lorenz96_solver.o"],
)]


setup(
  name = 'Lorenz96 solve routine',
  cmdclass = {'build_ext': build_ext},
  include_dirs = [numpy.get_include()],
  ext_modules = ext_modules
)

