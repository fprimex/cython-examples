from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [Extension(
    name="quad_openmp_wrapper",
    sources=["quad_openmp_wrapper.pyx"],
    extra_compile_args=['-fopenmp'],
    extra_link_args=['-lgomp'],
    extra_objects=["quad_openmp.o", "f1.o", "f2.o"],
)]


setup(
  name = 'Quadrature routine',
  cmdclass = {'build_ext': build_ext},
  ext_modules = ext_modules
)

