---
grand_parent: Mitchell Libraries
parent: Data Structures and Utilities
---
# Linear Algebra (GSL Bindings)

Mitchell includes bindings to a portion of the GNU Scientific Library (GSL) for
performing linear algebra computations. The provided bindings are listed below.
Documentation on the behavior of these procedures can be found at the
[GSL documentation page](https://www.gnu.org/software/gsl/doc/html/index.html).

Specific documentation for the dense linear algebra bindings can be found at

- [Vectors and Matrices](https://www.gnu.org/software/gsl/doc/html/vectors.html), and
- [BLAS Support](https://www.gnu.org/software/gsl/doc/html/blas.html).

Specific documentation for the sparse linear algebra bindings can be found at

- [Sparse Matrices](https://www.gnu.org/software/gsl/doc/html/spmatrix.html), and
- [Sparse BLAS Support](https://www.gnu.org/software/gsl/doc/html/spblas.html).

## Interface

### Types

- `type Vector`
- `type Matrix`
- `type VectorComplex`
- `type EigenGenWorkspace`
- `type EigenGenSymmvWorkspace`
- Flag used for `blas_dgemv`, `blas_dgemm`, and `spblas_dgemv`.
    ```
    datatype CblasTranspose =
             CblasNoTrans
             | CblasTrans
             | CblasConjTrans
    ```
- Flag used for `spmatrix_alloc_nzmax`.
    ```
    datatype SpType =
             SpMatrixTriplet
             | SpMatrixCcs
             | SpMatrixCrs

    ```

### Methods

#### Dense

- `val error : string * string * Int32.int * Int32.int -> unit`
- `val stream_printf : string * string * Int32.int * string -> unit`
- `val strerror : Int32.int -> string`
- `val error_handler_t : string * string * Int32.int * Int32.int -> unit`
- `val stream_handler_t : string * string * Int32.int * string -> unit`
- `val vector_alloc : Int64.int -> Vector`
- `val vector_calloc : Int64.int -> Vector`
- `val vector_alloc_from_vector : Vector * Int64.int * Int64.int * Int64.int -> Vector`
- `val vector_free : Vector -> unit`
- `val vector_set_zero : Vector -> unit`
- `val vector_set_all : Vector * Real64.real -> unit`
- `val vector_set_basis : Vector * Int64.int -> Int32.int`
- `val vector_memcpy : Vector * Vector -> Int32.int`
- `val vector_reverse : Vector -> Int32.int`
- `val vector_swap : Vector * Vector -> Int32.int`
- `val vector_swap_elements : Vector * Int64.int * Int64.int -> Int32.int`
- `val vector_max : Vector -> Real64.real`
- `val vector_min : Vector -> Real64.real`
- `val vector_minmax : Vector * Real64.real vector * Real64.real vector -> unit`
- `val vector_max_index : Vector -> Int64.int`
- `val vector_min_index : Vector -> Int64.int`
- `val vector_add : Vector * Vector -> Int32.int`
- `val vector_sub : Vector * Vector -> Int32.int`
- `val vector_mul : Vector * Vector -> Int32.int`
- `val vector_div : Vector * Vector -> Int32.int`
- `val vector_scale : Vector * Real64.real -> Int32.int`
- `val vector_add_constant : Vector * Real64.real -> Int32.int`
- `val vector_equal : Vector * Vector -> Int32.int`
- `val vector_isnull : Vector -> Int32.int`
- `val vector_ispos : Vector -> Int32.int`
- `val vector_isneg : Vector -> Int32.int`
- `val vector_isnonneg : Vector -> Int32.int`
- `val vector_get : Vector * Int64.int -> Real64.real`
- `val vector_set : Vector * Int64.int * Real64.real -> unit`
- `val vector_ptr : Vector * Int64.int -> Real64.real vector`
- `val vector_const_ptr : Vector * Int64.int -> Real64.real vector`
- `val vector_complex_alloc : Int64.int -> VectorComplex`
- `val vector_complex_calloc : Int64.int -> VectorComplex`
- `val vector_complex_alloc_from_vector : VectorComplex * Int64.int * Int64.int * Int64.int -> VectorComplex`
- `val vector_complex_free : VectorComplex -> unit`
- `val vector_complex_set_zero : VectorComplex -> unit`
- `val vector_complex_set_basis : VectorComplex * Int64.int -> Int32.int`
- `val vector_complex_memcpy : VectorComplex * VectorComplex -> Int32.int`
- `val vector_complex_reverse : VectorComplex -> Int32.int`
- `val vector_complex_swap : VectorComplex * VectorComplex -> Int32.int`
- `val vector_complex_swap_elements : VectorComplex * Int64.int * Int64.int -> Int32.int`
- `val vector_complex_equal : VectorComplex * VectorComplex -> Int32.int`
- `val vector_complex_isnull : VectorComplex -> Int32.int`
- `val vector_complex_ispos : VectorComplex -> Int32.int`
- `val vector_complex_isneg : VectorComplex -> Int32.int`
- `val vector_complex_isnonneg : VectorComplex -> Int32.int`
- `val vector_complex_add : VectorComplex * VectorComplex -> Int32.int`
- `val vector_complex_sub : VectorComplex * VectorComplex -> Int32.int`
- `val vector_complex_mul : VectorComplex * VectorComplex -> Int32.int`
- `val vector_complex_div : VectorComplex * VectorComplex -> Int32.int`
- `val matrix_alloc : Int64.int * Int64.int -> Matrix`
- `val matrix_calloc : Int64.int * Int64.int -> Matrix`
- `val matrix_alloc_from_matrix : Matrix * Int64.int * Int64.int * Int64.int * Int64.int -> Matrix`
- `val vector_alloc_row_from_matrix : Matrix * Int64.int -> Vector`
- `val vector_alloc_col_from_matrix : Matrix * Int64.int -> Vector`
- `val matrix_free : Matrix -> unit`
- `val matrix_set_zero : Matrix -> unit`
- `val matrix_set_identity : Matrix -> unit`
- `val matrix_set_all : Matrix * Real64.real -> unit`
- `val matrix_memcpy : Matrix * Matrix -> Int32.int`
- `val matrix_swap : Matrix * Matrix -> Int32.int`
- `val matrix_swap_rows : Matrix * Int64.int * Int64.int -> Int32.int`
- `val matrix_swap_columns : Matrix * Int64.int * Int64.int -> Int32.int`
- `val matrix_swap_rowcol : Matrix * Int64.int * Int64.int -> Int32.int`
- `val matrix_transpose : Matrix -> Int32.int`
- `val matrix_transpose_memcpy : Matrix * Matrix -> Int32.int`
- `val matrix_max : Matrix -> Real64.real`
- `val matrix_min : Matrix -> Real64.real`
- `val matrix_minmax : Matrix * Real64.real vector * Real64.real vector -> unit`
- `val matrix_equal : Matrix * Matrix -> Int32.int`
- `val matrix_isnull : Matrix -> Int32.int`
- `val matrix_ispos : Matrix -> Int32.int`
- `val matrix_isneg : Matrix -> Int32.int`
- `val matrix_isnonneg : Matrix -> Int32.int`
- `val matrix_add : Matrix * Matrix -> Int32.int`
- `val matrix_sub : Matrix * Matrix -> Int32.int`
- `val matrix_mul_elements : Matrix * Matrix -> Int32.int`
- `val matrix_div_elements : Matrix * Matrix -> Int32.int`
- `val matrix_scale : Matrix * Real64.real -> Int32.int`
- `val matrix_add_constant : Matrix * Real64.real -> Int32.int`
- `val matrix_add_diagonal : Matrix * Real64.real -> Int32.int`
- `val matrix_get_row : Vector * Matrix * Int64.int -> Int32.int`
- `val matrix_get_col : Vector * Matrix * Int64.int -> Int32.int`
- `val matrix_set_row : Matrix * Int64.int * Vector -> Int32.int`
- `val matrix_set_col : Matrix * Int64.int * Vector -> Int32.int`
- `val matrix_get : Matrix * Int64.int * Int64.int -> Real64.real`
- `val matrix_set : Matrix * Int64.int * Int64.int * Real64.real -> unit`
- `val matrix_ptr : Matrix * Int64.int * Int64.int -> Real64.real vector`
- `val matrix_const_ptr : Matrix * Int64.int * Int64.int -> Real64.real vector`
- `val log1p : Real64.real -> Real64.real`
- `val expm1 : Real64.real -> Real64.real`
- `val hypot : Real64.real * Real64.real -> Real64.real`
- `val hypot3 : Real64.real * Real64.real * Real64.real -> Real64.real`
- `val acosh : Real64.real -> Real64.real`
- `val asinh : Real64.real -> Real64.real`
- `val atanh : Real64.real -> Real64.real`
- `val isnan : Real64.real -> Int32.int`
- `val isinf : Real64.real -> Int32.int`
- `val finite : Real64.real -> Int32.int`
- `val nan : unit -> Real64.real`
- `val posinf : unit -> Real64.real`
- `val neginf : unit -> Real64.real`
- `val fdiv : Real64.real * Real64.real -> Real64.real`
- `val coerce_double : Real64.real -> Real64.real`
- `val ldexp : Real64.real * Int32.int -> Real64.real`
- `val fcmp : Real64.real * Real64.real * Real64.real -> Int32.int`
- `val pow_2 : Real64.real -> Real64.real`
- `val pow_3 : Real64.real -> Real64.real`
- `val pow_4 : Real64.real -> Real64.real`
- `val pow_5 : Real64.real -> Real64.real`
- `val pow_6 : Real64.real -> Real64.real`
- `val pow_7 : Real64.real -> Real64.real`
- `val pow_8 : Real64.real -> Real64.real`
- `val pow_9 : Real64.real -> Real64.real`
- `val pow_int : Real64.real * Int32.int -> Real64.real`
- `val max : Real64.real * Real64.real -> Real64.real`
- `val min : Real64.real * Real64.real -> Real64.real`
- `val cblas_ddot : Int32.int * Real64.real vector * Int32.int * Real64.real vector * Int32.int -> Real64.real`
- `val cblas_dnrm2 : Int32.int * Real64.real vector * Int32.int -> Real64.real`
- `val cblas_dasum : Int32.int * Real64.real vector * Int32.int -> Real64.real`
- `val cblas_idamax : Int32.int * Real64.real vector * Int32.int -> Int64.int`
- `val cblas_dswap : Int32.int * Real64.real vector * Int32.int * Real64.real vector * Int32.int -> unit`
- `val cblas_dcopy : Int32.int * Real64.real vector * Int32.int * Real64.real vector * Int32.int -> unit`
- `val cblas_daxpy : Int32.int * Real64.real * Real64.real vector * Int32.int * Real64.real vector * Int32.int -> unit`
- `val cblas_drotg : Real64.real vector * Real64.real vector * Real64.real vector * Real64.real vector -> unit`
- `val cblas_drotmg : Real64.real vector * Real64.real vector * Real64.real vector * Real64.real * Real64.real vector -> unit`
- `val cblas_drot : Int32.int * Real64.real vector * Int32.int * Real64.real vector * Int32.int * Real64.real * Real64.real -> unit`
- `val cblas_drotm : Int32.int * Real64.real vector * Int32.int * Real64.real vector * Int32.int * Real64.real vector -> unit`
- `val cblas_dscal : Int32.int * Real64.real * Real64.real vector * Int32.int -> unit`
- `val blas_ddot : Vector * Vector * Real64.real vector -> Int32.int`
- `val blas_dnrm2 : Vector -> Real64.real`
- `val blas_dasum : Vector -> Real64.real`
- `val blas_dznrm2 : VectorComplex -> Real64.real`
- `val blas_dzasum : VectorComplex -> Real64.real`
- `val blas_dswap : Vector * Vector -> Int32.int`
- `val blas_dcopy : Vector * Vector -> Int32.int`
- `val blas_daxpy : Real64.real * Vector * Vector -> Int32.int`
- `val blas_zswap : VectorComplex * VectorComplex -> Int32.int`
- `val blas_zcopy : VectorComplex * VectorComplex -> Int32.int`
- `val blas_drot : Vector * Vector * Real64.real * Real64.real -> Int32.int`
- `val blas_dscal : Real64.real * Vector -> unit`
- `val blas_zdscal : Real64.real * VectorComplex -> unit`
- `val blas_dger : Real64.real * Vector * Vector * Matrix -> Int32.int`
- `val linalg_matmult : Matrix * Matrix * Matrix -> Int32.int`
- `val linalg_householder_transform : Vector -> Real64.real`
- `val linalg_householder_hm : Real64.real * Vector * Matrix -> Int32.int`
- `val linalg_householder_mh : Real64.real * Vector * Matrix -> Int32.int`
- `val linalg_householder_hv : Real64.real * Vector * Vector -> Int32.int`
- `val linalg_householder_hm1 : Real64.real * Matrix -> Int32.int`
- `val linalg_hessenberg_decomp : Matrix * Vector -> Int32.int`
- `val linalg_hessenberg_unpack : Matrix * Vector * Matrix -> Int32.int`
- `val linalg_hessenberg_unpack_accum : Matrix * Vector * Matrix -> Int32.int`
- `val linalg_hessenberg_set_zero : Matrix -> Int32.int`
- `val linalg_hessenberg_submatrix : Matrix * Matrix * Int64.int * Vector -> Int32.int`
- `val linalg_hesstri_decomp : Matrix * Matrix * Matrix * Matrix * Vector -> Int32.int`
- `val linalg_SV_decomp : Matrix * Matrix * Vector * Vector -> Int32.int`
- `val linalg_SV_decomp_mod : Matrix * Matrix * Matrix * Vector * Vector -> Int32.int`
- `val linalg_SV_decomp_jacobi : Matrix * Matrix * Vector -> Int32.int`
- `val linalg_SV_solve : Matrix * Matrix * Vector * Vector * Vector -> Int32.int`
- `val linalg_SV_leverage : Matrix * Vector -> Int32.int`
- `val linalg_LU_det : Matrix * Int32.int -> Real64.real`
- `val linalg_LU_lndet : Matrix -> Real64.real`
- `val linalg_LU_sgndet : Matrix * Int32.int -> Int32.int`
- `val linalg_QR_decomp : Matrix * Vector -> Int32.int`
- `val linalg_QR_solve : Matrix * Vector * Vector * Vector -> Int32.int`
- `val linalg_QR_svx : Matrix * Vector * Vector -> Int32.int`
- `val linalg_QR_lssolve : Matrix * Vector * Vector * Vector * Vector -> Int32.int`
- `val linalg_QR_QRsolve : Matrix * Matrix * Vector * Vector -> Int32.int`
- `val linalg_QR_Rsolve : Matrix * Vector * Vector -> Int32.int`
- `val linalg_QR_Rsvx : Matrix * Vector -> Int32.int`
- `val linalg_QR_update : Matrix * Matrix * Vector * Vector -> Int32.int`
- `val linalg_QR_QTvec : Matrix * Vector * Vector -> Int32.int`
- `val linalg_QR_Qvec : Matrix * Vector * Vector -> Int32.int`
- `val linalg_QR_QTmat : Matrix * Vector * Matrix -> Int32.int`
- `val linalg_QR_matQ : Matrix * Vector * Matrix -> Int32.int`
- `val linalg_QR_unpack : Matrix * Vector * Matrix * Matrix -> Int32.int`
- `val linalg_R_solve : Matrix * Vector * Vector -> Int32.int`
- `val linalg_R_svx : Matrix * Vector -> Int32.int`
- `val linalg_QRPT_rank : Matrix * Real64.real -> Int64.int`
- `val linalg_QRPT_rcond : Matrix * Real64.real vector * Vector -> Int32.int`
- `val linalg_COD_unpack : Matrix * Vector * Vector * Int64.int * Matrix * Matrix * Matrix -> Int32.int`
- `val linalg_COD_matZ : Matrix * Vector * Int64.int * Matrix * Vector -> Int32.int`
- `val linalg_LQ_decomp : Matrix * Vector -> Int32.int`
- `val linalg_LQ_solve_T : Matrix * Vector * Vector * Vector -> Int32.int`
- `val linalg_LQ_svx_T : Matrix * Vector * Vector -> Int32.int`
- `val linalg_LQ_lssolve_T : Matrix * Vector * Vector * Vector * Vector -> Int32.int`
- `val linalg_LQ_Lsolve_T : Matrix * Vector * Vector -> Int32.int`
- `val linalg_LQ_Lsvx_T : Matrix * Vector -> Int32.int`
- `val linalg_L_solve_T : Matrix * Vector * Vector -> Int32.int`
- `val linalg_LQ_vecQ : Matrix * Vector * Vector -> Int32.int`
- `val linalg_LQ_vecQT : Matrix * Vector * Vector -> Int32.int`
- `val linalg_LQ_unpack : Matrix * Vector * Matrix * Matrix -> Int32.int`
- `val linalg_LQ_update : Matrix * Matrix * Vector * Vector -> Int32.int`
- `val linalg_LQ_LQsolve : Matrix * Matrix * Vector * Vector -> Int32.int`
- `val linalg_cholesky_decomp : Matrix -> Int32.int`
- `val linalg_cholesky_decomp1 : Matrix -> Int32.int`
- `val linalg_cholesky_solve : Matrix * Vector * Vector -> Int32.int`
- `val linalg_cholesky_svx : Matrix * Vector -> Int32.int`
- `val linalg_cholesky_invert : Matrix -> Int32.int`
- `val linalg_cholesky_decomp_unit : Matrix * Vector -> Int32.int`
- `val linalg_cholesky_scale : Matrix * Vector -> Int32.int`
- `val linalg_cholesky_scale_apply : Matrix * Vector -> Int32.int`
- `val linalg_cholesky_decomp2 : Matrix * Vector -> Int32.int`
- `val linalg_cholesky_svx2 : Matrix * Vector * Vector -> Int32.int`
- `val linalg_cholesky_solve2 : Matrix * Vector * Vector * Vector -> Int32.int`
- `val linalg_cholesky_rcond : Matrix * Real64.real vector * Vector -> Int32.int`
- `val linalg_symmtd_decomp : Matrix * Vector -> Int32.int`
- `val linalg_symmtd_unpack : Matrix * Vector * Matrix * Vector * Vector -> Int32.int`
- `val linalg_symmtd_unpack_T : Matrix * Vector * Vector -> Int32.int`
- `val linalg_HH_solve : Matrix * Vector * Vector -> Int32.int`
- `val linalg_HH_svx : Matrix * Vector -> Int32.int`
- `val linalg_solve_symm_tridiag : Vector * Vector * Vector * Vector -> Int32.int`
- `val linalg_solve_tridiag : Vector * Vector * Vector * Vector * Vector -> Int32.int`
- `val linalg_solve_symm_cyc_tridiag : Vector * Vector * Vector * Vector -> Int32.int`
- `val linalg_solve_cyc_tridiag : Vector * Vector * Vector * Vector * Vector -> Int32.int`
- `val linalg_bidiag_decomp : Matrix * Vector * Vector -> Int32.int`
- `val linalg_bidiag_unpack : Matrix * Vector * Matrix * Vector * Matrix * Vector * Vector -> Int32.int`
- `val linalg_bidiag_unpack2 : Matrix * Vector * Vector * Matrix -> Int32.int`
- `val linalg_bidiag_unpack_B : Matrix * Vector * Vector -> Int32.int`
- `val linalg_balance_matrix : Matrix * Vector -> Int32.int`
- `val linalg_balance_accum : Matrix * Vector -> Int32.int`
- `val linalg_balance_columns : Matrix * Vector -> Int32.int`
- `val linalg_tri_upper_rcond : Matrix * Real64.real vector * Vector -> Int32.int`
- `val linalg_tri_lower_rcond : Matrix * Real64.real vector * Vector -> Int32.int`
- `val linalg_tri_upper_invert : Matrix -> Int32.int`
- `val linalg_tri_lower_invert : Matrix -> Int32.int`
- `val linalg_tri_upper_unit_invert : Matrix -> Int32.int`
- `val linalg_tri_lower_unit_invert : Matrix -> Int32.int`
- `val linalg_givens : Real64.real * Real64.real * Real64.real vector * Real64.real vector -> unit`
- `val linalg_givens_gv : Vector * Int64.int * Int64.int * Real64.real * Real64.real -> unit`
- `val eigen_gensymm_standardize : Matrix * Matrix -> Int32.int`
- `val eigen_gensymmv_alloc : Int64.int -> EigenGenSymmvWorkspace`
- `val eigen_gensymmv_free : EigenGenSymmvWorkspace -> unit`
- `val eigen_gensymmv : Matrix * Matrix * Vector * Matrix * EigenGenSymmvWorkspace -> Int32.int`
- `val eigen_gen_alloc : Int64.int -> EigenGenWorkspace`
- `val eigen_gen_free : EigenGenWorkspace -> unit`
- `val eigen_gen_params : Int32.int * Int32.int * Int32.int * EigenGenWorkspace -> unit`
- `val eigen_gen : Matrix * Matrix * VectorComplex * Vector * EigenGenWorkspace -> Int32.int`
- `val eigen_gen_QZ : Matrix * Matrix * VectorComplex * Vector * Matrix * Matrix * EigenGenWorkspace -> Int32.int`
- `val schur_gen_eigvals : Matrix * Matrix * Real64.real vector * Real64.real vector * Real64.real vector * Real64.real vector * Real64.real vector -> Int32.int`
- `val schur_solve_equation : Real64.real * Matrix * Real64.real * Real64.real * Real64.real * Vector * Vector * Real64.real vector * Real64.real vector * Real64.real -> Int32.int`
- `val blas_dgemv : CblasTranspose * Real64.real * Matrix * Vector * Real64.real * Vector -> Int32.int`
- `val blas_dgemm : CblasTranspose * CblasTranspose * Real64.real * Matrix * Matrix * Real64.real * Matrix -> Int32.int`

#### Sparse

- `val spmatrix_alloc : Int64.int * Int64.int -> SpMatrix`
- `val spmatrix_alloc_nzmax : Int64.int * Int64.int * Int64.int * SpType -> SpMatrix`
- `val spmatrix_free : SpMatrix -> unit`
- `val spmatrix_get : SpMatrix * Int64.int * Int64.int -> Real64.real`
- `val spmatrix_set : SpMatrix * Int64.int * Int64.int * Real64.real -> Int32.int`
- `val spmatrix_set_zero : SpMatrix -> Int32.int`
- `val spmatrix_memcpy : SpMatrix * SpMatrix -> Int32.int`
- `val spmatrix_transpose_memcpy : SpMatrix * SpMatrix -> Int32.int`
- `val spmatrix_transpose : SpMatrix -> Int32.int`
- `val spmatrix_transpose2 : SpMatrix -> Int32.int`
- `val spmatrix_add : SpMatrix * SpMatrix * SpMatrix -> Int32.int`
- `val spmatrix_scale : SpMatrix * Real64.real -> Int32.int`
- `val spmatrix_nnz : SpMatrix -> Int64.int`
- `val spmatrix_d2sp : SpMatrix * Matrix -> Int32.int`
- `val spmatrix_sp2d : Matrix * SpMatrix -> Int32.int`
- `val spblas_gemv : CblasTranspose * Real64.real * SpMatrix * Vector * Real64.real * Vector -> Int32.int`
- `val spblas_dgemm : Real64.real * SpMatrix * SpMatrix * SpMatrix -> Int32.int`
