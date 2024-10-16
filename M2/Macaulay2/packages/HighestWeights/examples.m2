--------------------------------------------------------------------------------
-- Copyright 2014  Federico Galetto
--
-- This program is free software: you can redistribute it and/or modify it under
-- the terms of the GNU General Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your option) any later
-- version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
-- details.
--
-- You should have received a copy of the GNU General Public License along with
-- this program.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------------------------------

doc ///
   Key
       "Example 1"
   Headline
       The coordinate ring of the Grassmannian
   Description
    Text
    	Let $E={\mathbb C}^6$, the standard representation of $SL_6 ({\mathbb C})$, with coordinate basis $\{e_0,\ldots,e_5\}$. The Grassmannian $V = Gr (2,E^*)$ is the projective variety which parametrizes two dimensional subspaces of  $E^*$; it is embedded in $\PP (\wedge^2 E^*)$ using the Pl\"ucker equations (see Shafarevich - Basic Algebraic Geometry 1, Ch. I, Sec. 4.1). Consider $\wedge^2 E^*$ as a complex affine space. Let $C$ be the affine cone over $V$, i.e., the subvariety of $\wedge^2 E^*$ which is the union of all the one dimensional subspaces of $\wedge^2 E^*$ belonging to $V$. The space $\wedge^2 E^*$ has a natural action of $SL_6 ({\mathbb C})$ which fixes $C$.
	
	Our polynomial ring $R$ is the ring of polynomial functions over $\wedge^2 E^*$, i.e., the symmetric algebra $Sym(\wedge^2 E)$. The elements $p_{i,j} = e_i \wedge e_j$, for $0\leq i < j \leq 5$, form a basis of weight vectors of $\wedge^2 E$ and will be the variables in $R$. The defining ideal of $C$ is generated by the Pl\"ucker equations; this ideal, which we call $I$, can be conveniently obtained in @TT "M2"@ using the command @TO "Grassmannian"@. We resolve the quotient $R/I$ as an $R$-module and call @TT "RI"@ the minimal free resolution.
	
    Example
	I=Grassmannian(1,5,CoefficientRing=>QQ); R=ring I;
	RI=freeResolution I; betti RI
    Text
    	Now we assign weights to the variables of $R$. First we input the weights of $e_0,\ldots,e_5$ in a list @TT "L"@.
	
    Example
	L={{1,0,0,0,0},{-1,1,0,0,0},{0,-1,1,0,0},{0,0,-1,1,0},{0,0,0,-1,1},{0,0,0,0,-1}}
    Text
    	The weight of $p_{i,j} = e_i \wedge e_j$ is the sum of the weights of $e_i$ and $e_j$. The subscripts of the variables $p_{i,j}$ are the elements of @TT "subsets({0,1,2,3,4,5},2)"@, the 2-subsets of the set $\{0,1,2,3,4,5\}$. Hence taking sums of pairs of weights in @TT "L"@ over this indexing set will give us a complete list of weights for the variables $p_{i,j}$, as listed by @TT "M2"@.
	
    Example
    	W=apply(subsets({0,1,2,3,4,5},2),s->L_(s_0)+L_(s_1))
    Text
    	We declare @TT "D"@ to be the Dynkin type $A_5$, which is the type of the group $SL_6 ({\mathbb C})$. Then we attach the weights in @TT "W"@ to the variables in $R$ using the command @TO "setWeights"@; the arguments are in order the ring, the type and the weights of the variables.
	
	The output will be the highest weight decomposition of the ${\mathbb C}$-linear subspace of $R$ generated by its variables; it is given in the form of a @TT "Tally"@, with keys describing the highest weights of the irreducible representation appearing in the decomposition and values equal to the multiplicities of those representations.
	
	In this case, we get simply @TT "{0, 1, 0, 0, 0} => 1"@ which means that the decomposition contains only one copy of the irreducible representation with highest weight @TT "{0, 1, 0, 0, 0}"@, i.e., $\wedge^2 E$ as expected.
	
    Example
    	D=dynkinType{{"A",5}}; setWeights(R,D,W)
    Text
    	All monomials in $R$ are weight vectors. To recover the weight of a monomial, use the command @TO "getWeights"@ with the monomial as the argument.
	
    Example
    	getWeights(p_(0,1)*p_(1,2))
    Text
    	We can now issue the command @TO "highestWeightsDecomposition"@ to obtain the decomposition of the representations corresponding to the free modules in the resolution; the only argument is the resolution @TT "RI"@. Suppose the free modules in @TT "RI"@ are $F_0, \ldots, F_6$. The outermost @TT "HashTable"@ in the output has keys equal to the subscripts of the free modules in @TT "RI"@. The value corresponding to a key $i$ is itself a  @TT "HashTable"@ with keys equal to the degrees of the generators of $F_i$. Finally the value corresponding to a certain degree $d$ is a @TT "Tally"@ containing the highest weight decomposition of the representation $(F_i/m F_i)_d$ where $m$ is the maximal ideal generated by the variables in $R$.
	
    Example
    	highestWeightsDecomposition(RI)
    Text
    	By analyzing the above output, we obtain the following description for @TT "RI"@:
	$$R \leftarrow \wedge^4 E \otimes R(-2) \leftarrow S_{2,1,1,1,1} E \otimes R(-3) \leftarrow S_{2} E \otimes R(-4) \oplus S_{2,2,2,2,2} E \otimes R(-5) \leftarrow S_{2,1,1,1,1} E \otimes R(-6) \leftarrow \wedge^2 E \otimes R(-7) \leftarrow R(-9) \leftarrow 0$$
	Here $S_\lambda$ denotes the Schur functor associated to the partition $\lambda$ (for the construction of  Schur functors see Fulton, Harris - Representation Theory, Ch. 6 or Fulton - Young Tableaux, Ch. 8). Recall that the Schur module $S_{\lambda} {\mathbb C}^{n+1}$ is the irreducible representation of $SL_{n+1} {\mathbb C}$ with highest weight $(\lambda_1 -\lambda_2,\ldots,\lambda_{n-1} -\lambda_n,\lambda_n)$ written in the basis of fundamental weights (as all lists of weights used by this package).
	
	Next we turn to the coordinate ring of $C$, i.e., the quotient ring $Q=R/I$. We decompose its graded components in the range of degrees from 0 to 4, again with the command @TO "highestWeightsDecomposition"@. This time the arguments are the ring followed by the lowest and highest degrees in the range to be decomposed.
	
    Example
    	Q=R/I; highestWeightsDecomposition(Q,0,4)
    Text
    	We deduce that, for $d\in\{0,\ldots,4\}$, $(R/I)_d = S_{d,d} E$. We can also decompose the graded components of the ring $R$ in a range of degrees or in a single degree.
	
    Example
    	highestWeightsDecomposition(R,2)
    Text
    	For example, $R_2 = \wedge^4 E \oplus S_{2,2} E$. Since the representation $\wedge^4 E$ appears in $R_2$ but not in $(R/I)_2$, we deduce that it must be in $I_2$, the graded component of $I$ of degree 2. This can be verified directly by decomposing $I_2$ as follows.
	
    Example
    	highestWeightsDecomposition(I,2)
///

doc ///
   Key
       "Example 2"
   Headline
       The Buchsbaum-Rim complex
   Description
    Text
    	Let $E={\mathbb C}^6$ with coordinate basis $\{e_1,\ldots,e_6\}$ and $F={\mathbb C}^3$ with coordinate basis $\{f_1,f_2,f_3\}$. Denote $R$ the symmetric algebra $Sym(E\otimes F)$; $R$ is a polynomial ring with variables $x_{i,j} = e_i\otimes f_j$. We take $M$ to be the cokernel of a generic $3\times 6$ matrix of variables in $R$. The minimal free resolution of $M$ is an example of a Buchsbaum-Rim complex (see Eisenbud - Commutative Algebra, Appendix A2.6). We call this complex @TT "BR"@.
	
    Example
    	R=QQ[x_(1,1)..x_(6,3)];
	G=genericMatrix(R,3,6)
	M=coker G; BR=freeResolution M; betti BR
    Text
    	The ring $R$ carries a degree compatible action of $SL_6 ({\mathbb C}) \times SL_3 ({\mathbb C})$. Define the map of graded free $R$-modules
	$$\phi : E \otimes R(-1) \rightarrow F^* \otimes R, e_i \otimes 1 \mapsto \sum_{j=1}^3 f_j^* \otimes x_{i,j}$$
	where $\{f_1^*,f_2^*,f_3^*\}$ is the dual basis in $F^*$. The matrix of $\phi$ with respect to the bases $\{e_1\otimes 1,\ldots,e_6\otimes 1\}$ and $\{f_1^*\otimes 1,f_2^*\otimes 1,f_3^*\otimes 1\}$ is precisely the generic matrix $G$ introduced above. Moreover $\phi$ is $SL_6 ({\mathbb C}) \times SL_3 ({\mathbb C})$-equivariant, meaning that $\forall g\in SL_6 ({\mathbb C}) \times SL_3 ({\mathbb C})$, $\forall e\in E$ and $\forall r\in R$, we have $\phi (g.(e\otimes r)) = g.\phi (e\otimes r)$. This makes its cokernel $M$ a module with a compatible $SL_6 ({\mathbb C}) \times SL_3 ({\mathbb C})$-action.
	
	The weight of $x_{i,j} = e_i\otimes f_j$ is obtained by concatenating the weight of $e_i$ with that of $f_j$. First we record the weights of $e_1,\ldots,e_6$ in a list @TT "e"@ and those of $f_1,f_2,f_3$ in a list @TT "f"@. Then we concatenate them as illustrated below and attach the resulting list to the variables $x_{i,j}$. Care must be taken that the order of the weights matches the order of the variables.
	
    Example
	e={{1,0,0,0,0},{-1,1,0,0,0},{0,-1,1,0,0},{0,0,-1,1,0},{0,0,0,-1,1},{0,0,0,0,-1}};
	f={{1,0},{-1,1},{0,-1}};
	W=flatten table(e,f,(u,v)->u|v)
	D=dynkinType{{"A",5},{"A",2}}; setWeights(R,D,W)
    Text
    	In order to decompose the representations in a resolution, we need to ensure that the coordinate basis for at least one of the free modules in the resolution is a basis of weight vectors and then we need to input the weights of the elements of that basis. For our resolution @TT "BR"@, we could choose the first or the second free module. In fact, the first differential of @TT "BR"@ is the map $\phi : E \otimes R(-1) \rightarrow F^* \otimes R$ whose matrix was written with respect to the bases of weight vectors $\{e_1\otimes 1,\ldots,e_6\otimes 1\}$ and $\{f_1^*\otimes 1,f_2^*\otimes 1,f_3^*\otimes 1\}$. We choose to work with the first module, i.e., the codomain of $\phi$. Notice that the element $1\in R$ appearing in the tensor product has weight zero, hence it does not contribute to the weight of the basis elements.
	Also the $SL_6 ({\mathbb C})$ factor of our group acts trivially on $F^*$, hence to obtain the weight of $f_1^*\otimes 1$ we concatenate @TT "{0,0,0,0,0}"@, the weight of the trivial representation of $SL_6 ({\mathbb C})$, with @TT "{-1,0}"@, the weight of $f_1^*$. We proceed similarly for the other basis vectors and record the weights in the list @TT "U0"@.
	
    Example
    	U0={{0,0,0,0,0,-1,0},{0,0,0,0,0,1,-1},{0,0,0,0,0,0,1}};
    Text
    	Now we are ready to decompose @TT "BR"@. We issue the command @TO "highestWeightsDecomposition"@ with three arguments: the first is @TT "BR"@; the second is an integer $i$ informing @TT "M2"@ that we wish to provide the weights in the $i$-th free module of the complex, and the third is the list of weights in the coordinate basis of the $i$-th module (remember the indexing of the modules starts from zero in @TT "M2"@).
	
    Example
    	H0=highestWeightsDecomposition(BR,0,U0)
    Text
    	We deduce that @TT "BR"@ decomposes as:
	$$F^*\otimes R \leftarrow E\otimes R(-1) \leftarrow \wedge^4 E \otimes R(-4) \leftarrow \wedge^5 E \otimes F \otimes R(-5) \leftarrow \mathbb{S}_2 F \otimes R(-6) \leftarrow 0$$
	Here $S_\lambda$ denotes the Schur functor associated to the partition $\lambda$ (for the construction of  Schur functors see Fulton, Harris - Representation Theory, Ch. 6 or Fulton - Young Tableaux, Ch. 8). Recall that the Schur module $S_{\lambda} {\mathbb C}^{n+1}$ is the irreducible representation of $SL_{n+1} {\mathbb C}$ with highest weight $(\lambda_1 -\lambda_2,\ldots,\lambda_{n-1} -\lambda_n,\lambda_n)$ written in the basis of fundamental weights (as all lists of weights used by this package).
	
	If we choose to start from the second module, we need to provide the list of weights of the elements $e_1\otimes 1,\ldots,e_6\otimes 1$. The commands look as follows:
	
    Example
    	U1={{1,0,0,0,0,0,0},{-1,1,0,0,0,0,0},{0,-1,1,0,0,0,0},{0,0,-1,1,0,0,0},{0,0,0,-1,1,0,0},{0,0,0,0,-1,0,0}};
	H1=highestWeightsDecomposition(BR,1,U1); H0===H1
    Text
    	Indeed the decomposition is the same.
	
	As with rings and ideals, we can decompose the graded components of a module. The difference is that we need to provide a list of weights for the generators of the presentation used to define the module. For our module $M$, this is exactly the list @TT "U0"@ introduced earlier. As usual, we may request to decompose a single degree or a range.
	
    Example
    	highestWeightsDecomposition(M,-1,2,U0)
    Text
    	Since $M$ is generated in degree zero, we see that the output contains an empty decomposition in degree $-1$. Whereas we see, for example, that $M_2 = \wedge^2 E \otimes S_{2,2} F \oplus S_{2} E \otimes S_{3,1} F$.
	
///

doc ///
   Key
       "Example 3"
   Headline
       A multigraded Eagon-Northcott complex
   Description
    Text
    	Let $E={\mathbb C}^3$ with coordinate basis $\{e_1,e_2,e_3\}$, $F={\mathbb C}^4$ with coordinate basis $\{f_1,\ldots,f_4\}$ and $H={\mathbb C}^2$ with coordinate basis $\{h_1,h_2\}$. Denote $R$ the symmetric algebra $Sym((E\oplus F)\otimes H)$; $R$ is a polynomial ring with variables $x_{i,j} = e_i\otimes h_j$ and $y_{i,j} = f_i\otimes h_j$. We take the variables $x_{i,j}$ to have degree $(1,0)$ and the variables $y_{i,j}$ to have degree $(0,1)$.
	Let $G$ be a $2\times 7$ generic matrix of variables in $R$ and $I$ the ideal generated by the $2\times 2$ minors of $G$. The minimal free resolution of $I$ is an example of an Eagon-Northcott complex (see Eisenbud - Commutative Algebra, Appendix A2.6).
	
    Example
	R=QQ[x_(1,1)..x_(3,2),y_(1,1)..y_(4,2),Degrees=>{6:{1,0},8:{0,1}}]
	G=genericMatrix(R,2,3)|genericMatrix(R,y_(1,1),2,4)
	I=minors(2,G);
	EN=freeResolution I; betti EN
    Text
    	Notice how the first three columns of $G$ involve only the $x_{i,j}$ variables while the other columns involve only the $y_{i,j}$ variables. In fact, $G$ is the matrix of the map
	$$\phi : E\otimes R(-1,0) \oplus F\otimes R(0,-1) \rightarrow H^* \otimes R, e_i \otimes 1 \mapsto \sum_{k=1}^2 h_k^* \otimes x_{i,k}, f_j \otimes 1 \mapsto \sum_{k=1}^2 h_k^* \otimes y_{j,k}$$
	with respect to the bases $\{e_1\otimes 1,\ldots,e_3\otimes 1,f_1\otimes 1,\ldots,f_4\otimes 1\}$ of the domain and $\{h_1^*\otimes 1,h_2^*\otimes 1\}$ of the codomain.
	
	The ring $R$ carries a degree compatible action of $SL_3 ({\mathbb C}) \times SL_4 ({\mathbb C}) \times SL_2 ({\mathbb C})$. Notice how the $SL_3 ({\mathbb C})$ factor acts non trivially on $E$, i.e., on the variables $x_{i,j}$, and trivially on $F$, i.e., on the variables $y_{i,j}$. The opposite holds for the $SL_4 ({\mathbb C})$ factor.
    	The map $\phi$ is $G$-equivariant and so the ideal generated by the $2\times 2$ of $\phi$ inherits the $G$-action on $R$.
	
	The weight of $x_{i,j} = e_i\otimes h_j$ is obtained by concatenating the weight of $e_i$ with the trivial weight @TT "{0,0,0}"@ for the action of $SL_4 ({\mathbb C})$ and then with the weight of $h_j$. Similarly the weight of $y_{i,j} = f_i\otimes h_j$ is obtained by concatenating the trivial weight @TT "{0,0}"@ for the action of $SL_3 ({\mathbb C})$ with the weight of $f_i$ and then with the weight of $h_j$.
	As in @TO "Example 2"@, we automate the process as illustrated below and then we attach the list of weights to the ring $R$.
	
    Example
	e={{1,0},{-1,1},{0,-1}}
	f={{1,0,0},{-1,1,0},{0,-1,1},{0,0,-1}}
    	h={{1},{-1}}
	W=(flatten table(e,h,(u,v)->u|{0,0,0}|v))|(flatten table(f,h,(u,v)->{0,0}|u|v))
	D=dynkinType{{"A",2},{"A",3},{"A",1}}; setWeights(R,D,W)
    Text
    	Now we decompose the resolution of $I$.
	
    Example
    	highestWeightsDecomposition(EN)
    Text
    	We show what part of the resolution looks like in terms of Schur functors:
	$$R \leftarrow (\wedge^2 F \otimes R(0,-2)) \oplus (E \otimes F \otimes R(-1,-1)) \oplus (\wedge^2 E \otimes R(-2,0)) \leftarrow (\wedge^3 F \otimes H \otimes R(0,-3)) \oplus (E \otimes \wedge^2 F \otimes H \otimes R(-1,-2)) \oplus (\wedge^2 E \otimes F \otimes H \otimes R(-2,-1)) \oplus (H \otimes R(-3,0)) \leftarrow \ldots$$
	
	Finally we decompose some graded components in the quotient ring $R/I$. Unlike with $\ZZ$-gradings, when working in the multigraded setting it is not possible to decompose a range of degrees but only one multidegree at a time.
	
    Example
    	Q=R/I
	highestWeightsDecomposition(Q,{2,0})
	highestWeightsDecomposition(Q,{1,1})
	highestWeightsDecomposition(Q,{0,2})
    Text
    	We have $Q_{(2,0)} = S_2 E \otimes S_2 H$, $Q_{(1,1)} = E \otimes F \otimes S_2 H$ and $Q_{(0,2)} = S_2 F \otimes S_2 H$.
	
///

doc ///
    Key
    	"Example 4"
    Headline
    	The Eisenbud-Fløystad-Weyman complex
    Description
     Text
     	We construct and decompose the Eisenbud-Fløystad-Weyman 
	complex of type (0,2,3,6) over a polynomial ring in 3 variables.
	The ring can be identified with $Sym(E)$, where $E$ is a complex
	vector space of dimension 3. The ring and the complex carry an 
	action of $SL(E)$.
	
	The complex is constructed using the package @TO "PieriMaps:: PieriMaps"@. 
	For more information on these complexes, we invite the reader to 
	consult the documentation of that package and the accompanying
	article.

     Example
     	R=QQ[x,y,z];
      	L={{1,0},{-1,1},{0,-1}};
      	D=dynkinType{{"A",2}};
      	setWeights(R,D,L)
      	loadPackage "PieriMaps";
      	f=pureFree({0,2,3,6},R)
     Text
     	The matrix above is a presentation of the module whose resolution
	is the complex in the title. The rows of the matrix are indexed by
	standard tableaux of shape $(2,2)$ and entries from $\{0,1,2\}$.
	The weight of one such tableau is $m_0*L_0+m_1*L_1+m_2*L_2$, where
	$m_i$ is the multiplicity of $i$ in the tableau. The command
	below generates all the weights.

     Example
     	W=apply(apply(standardTableaux(3, {2,2}), flatten), i->sum(apply(i,j->L_j)))
     Text
     	Next we generate the resolution and obtain its decomposition.
     
     Example
      	EFW=freeResolution coker f; betti EFW
	highestWeightsDecomposition(EFW,0,W)
     Text
     	We conclude that with the action of $SL(E)$ the complex has the 
	following structure:
	$$S_{2,2} E \otimes R \leftarrow S_{4,2} E \otimes R(-2) \leftarrow S_{4,3} E \otimes R(-3) \leftarrow E \otimes R(-6) \leftarrow 0$$
	where $S_\lambda$ denotes the Schur functor associated with the
	partition $\lambda$.
	
///

doc ///
   Key
       "Example 5"
   Headline
       The singular locus of a symplectic invariant
   Description
    Text
    	Consider the symplectic group $Sp(6,{\mathbb C})$ of type $C_3$.
	We denote $V(\omega)$ the highest weight representation of 
	$Sp(6,{\mathbb C})$ with highest weight $\omega$. We denote by
	$\omega_1,...,\omega_3$ the fundamental weights in the root 
	system of type $C_3$.
	
	The action of $Sp(6,{\mathbb C})$ on $V(\omega_3)$, the third 
	fundamental representation, has a unique invariant $\Delta$ of 
	degree 4. If we regard $V(\omega_3)$ as a complex affine space,
	$\Delta$ describes a hypersurface. We will determine and decompose
	the minimal free resolution of the coordinate ring of the singular
	locus of this hypersurface. This singular locus is one of the four
	orbit closures for the action of $Sp(6,{\mathbb C})$ on $V(\omega_3)$
	and has been studied, for example, in @HREF("http://arxiv.org/abs/1210.6410","Galetto - Free resolutions of orbit closures for the representations associated to gradings on 
	Lie algebras of type E6, F4 and G2")@. A concise description
	of this singular locus, together with a construction of the 
	representation $V(\omega_3)$, was also given in @HREF("http://dx.doi.org/10.1307/mmj/1123090775","Iliev, Ranestad - 
	Geometry of the Lagrangian Grassmannian LG(3,6) with Applications 
	to Brill–Noether Loci")@. We will follow the notation of this second 
	source.
	
       	The standard representation $V=V(\omega_1)$ of $Sp(6,{\mathbb C})$ 
	is a six dimensional complex vector space endowed with 
	a symplectic form. Being a symplectic space, $V$ is self dual.
	Let $x_1,...,x_6$ be a basis for the 
	coordinate functions on $V$. The symplectic form on $V$ can be 
	written as $x_1\wedge x_4 +x_3\wedge x_5 +x_3\wedge x_6 \in \wedge^2 V^*$.
	The wedge product with this form induces a map $V^* \to \wedge^3 V^*$
	whose cokernel is the representation $V(\omega_3)$. As such, the
	residue classes $x_{i,j,k}$ of the tensors $x_i\wedge x_j\wedge x_k$
	span $V(\omega_3)$. Since $V(\omega_3)$ is self dual, we can take
	the $x_{i,j,k}$ to span the coordinate functions on $V(\omega_3)$.
	Finally, some of the $x_{i,j,k}$ can be omitted and the remaining
	ones will be variables in our polynomial ring $R$.
	
    Example
    	R=QQ[x_{1,2,3},x_{1,2,4},x_{1,2,5},x_{1,2,6},x_{1,3,4},x_{1,3,5},x_{1,4,5},x_{1,4,6},x_{1,5,6},x_{2,3,4},x_{2,4,5},x_{2,4,6},x_{3,4,5},x_{4,5,6}]
    Text
    	The invariant $\Delta$ can be written in terms of certain matrices
	of variables, as indicated in our source.
	
    Example
    	X=matrix{{x_{2,3,4},-x_{1,3,4},x_{1,2,4}},{-x_{1,3,4},-x_{1,3,5},x_{1,2,5}},{x_{1,2,4},x_{1,2,5},x_{1,2,6}}}
	Y=matrix{{x_{1,5,6},-x_{1,4,6},x_{1,4,5}},{-x_{1,4,6},-x_{2,4,6},x_{2,4,5}},{x_{1,4,5},x_{2,4,5},x_{3,4,5}}}
	Delta=(x_{1,2,3}*x_{4,5,6}-trace(X*Y))^2+4*x_{1,2,3}*det(Y)+4*x_{4,5,6}*det(X)-4*sum(3,i->sum(3,j->det(submatrix'(X,{i},{j}))*det(submatrix'(Y,{i},{j}))));
	
    Text
    	The equations of the singular locus of the hypersurface cut out
	by $\Delta$ are the partial derivatives of $\Delta$. Let us
	calculate the resolution of this ideal.
	
    Example
    	I=ideal jacobian ideal Delta;
	RI=freeResolution I; betti RI
    Text
    	The root system of type $C_3$ is contained in $\RR^3$. It is easy
	to express the weight of each variable of the ring $R$ with respect
	to the coordinate basis of $\RR^3$. The weight of $x_{i,j,k}$ is 
	the vector $v_i+v_j+v_k$, where $v_h$ is the weight of
	$x_h$ in the coordinate basis of $\RR^3$.
	
    Example
    	v_1={1,0,0}; v_2={0,1,0}; v_3={0,0,1}; v_4={-1,0,0}; v_5={0,-1,0}; v_6={0,0,-1};
	ind = apply(gens R,g->(baseName g)#1)
	W'=apply(ind,j->v_(j_0)+v_(j_1)+v_(j_2))
    Text
    	Now we convert these weights into the basis of fundamental weights.
	To achieve this we make each previous weight into a column vector
	and join all column vectors into a matrix. Then we multiply on the
	left by the matrix $M$ expressing the change of basis from the coordinate
	basis of $\RR^3$ to the base of simple roots of $C_3$ (as described
	in Humphreys - Introduction to Lie Algebras and Representation 
	Theory, Ch. 12.1). Finally we multiply the resulting matrix on the 
    	left by $N$, the transpose of the Cartan matrix of $C_3$, 
	which expresses the change of
	basis from the simple roots to the fundamental weights of $C_3$.
	The columns of the matrix thus obtained are the desired weights,
	so they can be attached to the ring $R$.
	
    Example
    	M=inverse promote(matrix{{1,0,0},{-1,1,0},{0,-1,2}},QQ)
	D=dynkinType{{"C",3}}
	N=transpose promote(cartanMatrix(rootSystem(D)),QQ)
	W=entries transpose lift(N*M*(transpose matrix W'),ZZ)
	setWeights(R,D,W)
    Text
    	At this stage, we can issue the command to decompose the resolution.
	
    Example
    	highestWeightsDecomposition(RI)
    Text
    	We deduce that the resolution has the following structure
	$$R \leftarrow V(\omega_3) \otimes R(-3) \leftarrow V(2\omega_1) \otimes R(-4) \leftarrow V(\omega_2) \otimes R(-6) \leftarrow V(\omega_1) \otimes R(-7) \leftarrow 0$$
    	
	Let us also decompose some graded components of the quotient $R/I$.
	
    Example
    	highestWeightsDecomposition(R/I,0,4)
	
///

doc ///
   Key
       "Example 6"
   Headline
       The coordinate ring of the spinor variety
   Description
    Text
    	Consider the complex Lie group $SO(10)$ of type $D_5$. We denote 
	$V(\omega)$ the highest weight representation of $SO(10)$
	with highest weight $\omega$. We denote by
	$\omega_1,...,\omega_5$ the fundamental weights in the root 
	system of type $D_5$.
	
	We will obtain the minimal free resolution of the coordinate ring
	of the spinor variety of type $D_5$ (see @HREF("http://dx.doi.org/10.1016/j.jcta.2011.08.001",
	"Rincon - Isotropical linear spaces and valuated delta-matroids")@, 
        Sec. 2, for a concise 
	introduction to spinor varieties). The affine cone over the spinor
    	variety of type $D_5$ lives in the representation $V(\omega_5)$,
	the 5th fundamental representation of $SO(10)$, considered as an
	affine space. Polynomial functions on this affine space are given 
	by the symmetric algebra over the dual representation, i.e.,
	$V(\omega_4)$.
	
	Following the description in Fulton, Harris - 
	Representation Theory, Ch. 20.1, we can construct $V(\omega_4)$
	as $\wedge^0 E \oplus \wedge^2 E \oplus \wedge^4 E$, where
	$E$ is a 5 dimensional complex vector space. Let $\{e_0,...,e_4\}$
	be a basis of $E$. Then a basis of $V(\omega_4)$ is given by the
	exterior products $e_J = e_{j_1} \wedge ... \wedge e_{j_{2r}}$, for
	all subsets $J=\{j_1,...,j_{2r}\}$ of even cardinality of $\{0,...,
	4\}$. Denote by $x_J$ the variable corresponding to $e_J$ in $R$.
	
	The spinor variety of type $D_5$ is cut out by 
	quadratic equations which represent all possible relations among
	the sub Pfaffians of a $5\times 5$ generic skew symmetric matrix.
	A general description can be found for example in @HREF("http://dx.doi.org/10.3842/SIGMA.2009.078",
	"Manivel - On Spinor Varieties and Their Secants")@.
	
    Example
    	R=QQ[x_{}, x_{0,1}, x_{0,2}, x_{1,2}, x_{0,3}, x_{1,3}, x_{2,3}, x_{0,4}, x_{1,4}, x_{2,4}, x_{3,4}, x_{0,1,2,3}, x_{0,1,2,4}, x_{0,1,3,4}, x_{0,2,3,4}, x_{1,2,3,4}]
	I=ideal(x_{}*x_{0,1,2,3}-x_{0,1}*x_{2,3}+x_{0,2}*x_{1,3}-x_{0,3}*x_{1,2},
	    x_{}*x_{0,1,2,4}-x_{0,1}*x_{2,4}+x_{0,2}*x_{1,4}-x_{0,4}*x_{1,2},
	    x_{}*x_{0,1,3,4}-x_{0,1}*x_{3,4}+x_{0,3}*x_{1,4}-x_{0,4}*x_{1,3},
	    x_{}*x_{0,2,3,4}-x_{0,2}*x_{3,4}+x_{0,3}*x_{2,4}-x_{0,4}*x_{2,3},
	    x_{}*x_{1,2,3,4}-x_{1,2}*x_{3,4}+x_{1,3}*x_{2,4}-x_{1,4}*x_{2,3},
	    x_{0,1}*x_{0,2,3,4}-x_{0,2}*x_{0,1,3,4}+x_{0,3}*x_{0,1,2,4}-x_{0,4}*x_{0,1,2,3},
	    -x_{0,1}*x_{1,2,3,4}+x_{1,2}*x_{0,1,3,4}-x_{1,3}*x_{0,1,2,4}+x_{1,4}*x_{0,1,2,3},
	    x_{0,2}*x_{1,2,3,4}-x_{1,2}*x_{0,2,3,4}+x_{2,3}*x_{0,1,2,4}-x_{2,4}*x_{0,1,2,3},
	    -x_{0,3}*x_{1,2,3,4}+x_{1,3}*x_{0,2,3,4}-x_{2,3}*x_{0,1,3,4}+x_{3,4}*x_{0,1,2,3},
	    x_{0,4}*x_{1,2,3,4}-x_{1,4}*x_{0,2,3,4}+x_{2,4}*x_{0,1,3,4}-x_{3,4}*x_{0,1,2,4});
    	RI=freeResolution I; betti RI
    Text
    	The root system of type $D_5$ is contained in $\RR^5$. It is easy
	to express the weight of each variable of the ring $R$ with respect
	to the coordinate basis of $\RR^5$. The weight of $x_J$ is a vector
	$(a_1,...,a_5)\in\RR^5$, with $a_k = 1/2$ if $k\in J$ and $a_k = 
	-1/2$ otherwise.
	
    Example
    	ind = apply(gens R,g->(baseName g)#1)
    	makeWeight = J -> apply(5,i->if member(i,J) then 1/2 else -1/2)
	W'=apply(ind,makeWeight)
    Text
    	Now we convert these weights into the basis of fundamental weights.
	To achieve this we make each previous weight into a column vector
	and join all column vectors into a matrix. Then we multiply on the
	left by the matrix $M$ expressing the change of basis from the coordinate
	basis of $\RR^5$ to the base of simple roots of $D_5$ (as described
	in Humphreys - Introduction to Lie Algebras and Representation 
	Theory, Ch. 12.1). Finally we multiply the resulting matrix on the 
    	left by $N$, the transpose of the Cartan matrix of $D_5$, 
	which expresses the change of
	basis from the simple roots to the fundamental weights of $D_5$.
	The columns of the matrix thus obtained are the desired weights,
	so they can be attached to the ring $R$.
	
    Example
    	M=inverse promote(matrix{{1,0,0,0,0},{-1,1,0,0,0},{0,-1,1,0,0},{0,0,-1,1,1},{0,0,0,-1,1}},QQ)
	D=dynkinType{{"D",5}}
	N=transpose promote(cartanMatrix(rootSystem(D)),QQ)
	W=entries transpose lift(N*M*(transpose matrix W'),ZZ)
	setWeights(R,D,W)
    Text
    	At this stage, we can issue the command to decompose the resolution.
	
    Example
    	highestWeightsDecomposition(RI)
    Text
    	We deduce that the resolution has the following structure
	$$R \leftarrow V(\omega_1) \otimes R(-2) \leftarrow V(\omega_5) \otimes R(-3) \leftarrow V(\omega_4) \otimes R(-5) \leftarrow V(\omega_1) \otimes R(-6) \leftarrow R(-8) \leftarrow 0$$
    	
	Let us also decompose some graded components of the quotient $R/I$.
	
    Example
    	highestWeightsDecomposition(R/I,0,4)
    Text
    	We deduce that, for $d\in\{0,...,4\}$, $(R/I)_d = V(d\omega_4)$.
	
///

doc ///
   Key
       "Example 7"
   Headline
       With the exceptional group G2
   Description
    Text
    	Consider the exceptional group of type $G_2$; we denote $V(a,b)$ the highest weight representation of $G_2$ with highest weight $a\omega_1 + b\omega_2$, where $\omega_1$ and $\omega_2$ are the fundamental weights for $G_2$ (see Fulton, Harris - Representation Theory, Ch, 22.3 for a construction of the representations appearing in this example).
	We work over the polynomial ring $Sym(V(1,0))$, which has a natural action of $G_2$. For lack of a better notation, we index the variables in $R$ by their weight (recall that variables in $R$ must be weight vectors).
	Consider the maximal ideal $m$ generated by the variables of $R$. This ideal is clearly stable under the action of $G_2$. Moreover the minimal free resolution of $R/I$ is the Koszul complex over the variables of $R$ (see Eisenbud - Commutative Algebra, Ch. 17).
	
    Example
    	R=QQ[x_(-2, 1),x_(-1, 0),x_(-1, 1),x_(0, 0),x_(1,-1),x_(1, 0),x_(2,-1)]
	m=ideal vars R;
	K=koszulComplex gens m; betti K
    Text
    	Now we define  the list of weights of the variables and attach it to the ring.
	
    Example
    	W={{-2, 1},{-1, 0},{-1, 1},{0, 0},{1,-1},{1, 0},{2,-1}}
	D=dynkinType{{"G",2}}; setWeights(R,D,W)
    Text
    	We can ask to decompose the complex $K$ up to homological degree 3 using the option @TO "Range"@:
	
    Example
    	highestWeightsDecomposition(K,Range=>{0,3})
    Text
    	Then the first half of $K$ is:
	$$R \leftarrow V(1,0) \otimes R(-1) \leftarrow (V(0,1)\oplus V(1,0)) \otimes R(-2) \leftarrow (V(0,0)\oplus V(1,0)\oplus V(2,0)) \otimes R(-3) \leftarrow \ldots $$
	The second half can be reconstructed using the duality of the Koszul complex and the fact that all the representations in the first half are self dual.
    	
	While the quotient ring $R/m$ is isomorphic to ${\mathbb C}$, the trivial representation of $G_2$, it may be more interesting to decompose some graded components of $m$.
	
    Example
    	highestWeightsDecomposition(m,0,4)
    Text
    	Since $m$ is generated by the variables, it contains all graded components of $R$ except for the one in degree zero. In particular, the graded components of $R$ and $m$ coincide in degree 1 and higher, which is illustrated up to degree 4 by the computation below.
	
    Example
    	highestWeightsDecomposition(R,0,4)
///
