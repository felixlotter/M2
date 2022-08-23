doc ///
  Key
    "Hilbert scheme of 6 points in projective 3-space"
  Headline
    Betti table loci
  Description
    Text
      In this section, we use strongly stable ideals (Borel fixed ideals),
      generic initial ideals,
      Groebner strata, and Schreyer's algorithm for computing free resolutions,
      to find the components in the Hilbert scheme of 6 points, of the various Batti table loci.

      Let's assume for simplicity that the field $\mathbb{k}$ has characteristic zero.
      This is slightly too strong an assumption for what we are doing, but if the characteristic
      is finite but not so small, everything we say here will hold in that case too.
      Let $S = \mathbb{k}[x_0, \ldots, x_n]$.

    Text
      We work over a large finite field, one whose characteristic is large enough so that
      the subtleties of Borels over finite characteristic don't appear.  We use such a finite field,
      instead of $\mathbb{Q}$, so that the coefficients in the ideal aren't huge.
      This doesn't change the answers, but we need to check that afterwords.
    Example
      setRandomSeed 4332367823
      kk = ZZ/101
      S = kk[a,b,c,d];
    Text
      @SUBSECTION "Strongly stable ideals with a given Hilbert polynomial"@

      A {\bf strongly stable monomial ideal} is a monomial ideal $J$ such that if $x_i m$ is in $J$,
      then $x_j m$ is in $J$, for all $j < i$.  In characteristic zero, this coincides
      with the notion of an ideal being fixed under the Borel action of upper triangular 
      matrices.  There is a more complicated combinatorial description of Borel fixed ideals
      in positive characteristic, this is why we simplify here to characteristic zero.  

      There are only finitely many saturated Borel fixed monomial
      ideals of a given Hilbert polynomial (this is folklore, but
      D. Maclagan has a nice general paper which proves a sweeping
      generalization of this).  Alyson Reeves gave an algorithm in her
      Cornell thesis to compute all of the saturated Borels, with a given Hilbert polynomial.
      Moore and Nagel, and separately Albarelli-Lella (arxiv 1406.6924)
      have papers improving this construction, and the latter have implemented 
      a Macaulay2 package which computes these.
      
      As our running example computation, we consider the Hilbert scheme of 6 points in $\PP^3$.
      Here are all of the strongly stable ideals with Hilbert polynomial $p(z) = 6$ in 
      $\PP^3$.  We use the package {\bf StronglyStableIdeals} written by Albarelli and Lella.
    Example
      B6 = stronglyStableIdeals(6, S)
      B6 = nondegenerateBorels(6, S)
      B6/minimalBetti
    Example
      matrix for J in B6 list for d to 6 list hilbertFunction(d, J)
    Text
      Notice that each saturated Borel fixed ideal with this Hilbert polynomial
      has a different Hilbert function.
    Text
      @SUBSECTION "Generic initial ideals"@

      There are two key theorems (see Eisenbud's commutative algebra book, for an
      exposition) that we use here:
  
      {\bf Theorem}(Galligo, Bayer-Stillman) After a general change of coordinates, the initial ideal $J = in(g.I)$,
      under any term order,
      is Borel fixed (and hence, in characteristic zero, is strongly stable).

      {\bf Theorem}(Bayer-Stillman)
      The initial ideal $J = in(g.I)$, under graded reverse lex order,
      has the same depth, projective dimension and regularity as $I$.
      In characteristic zero, the regularity of $I$ is precisely the maximal
      degree of a Groebner basis generator of $g.I$.
      
      In particular, after a general, or sufficiently random, change of coordinates,
      the initial ideal $J$ is saturated, Borel fixed, and has the same regularity and projective
      dimension as $I$.  
      
      For example, if we take a random set of points, the resulting initial ideal 
      in graded reverse lex order is strongly stable (it is strongly stable for any order).
    Example
      I = pointsIdeal randomPoints(S, 6)
      degree I
      hilbertPolynomial(I, Projective => false)
      J = monomialIdeal leadTerm I
      isBorel J
      betti res I
    Text
      @SUBSECTION "The Groebner family of an initial ideal"@
      
      Given a monomial ideal $J$, and a term order (we generally always take the graded reverse lex 
      order), we can form a parameter space of ideals having initial ideal $J$.
      For each minimal generator $x^\alpha$ of $J$, consider the set $x^\gamma$ of monomials of the same degree,
      not in $J$.  For each such $\alpha$, form a polynomial
      
      $\phantom{WWWWW}      
          F_\alpha = x^\alpha + \sum_\gamma t_{\alpha, \gamma} x^\gamma
      $
      
      Let $U = T[x_0, \ldots, x_n]$, where $T = \mathbb{k}[t_{\alpha, \gamma}]$
      is the polynomial ring generated by all variables of the form $t_{\alpha, \gamma}$ as above.
      Let $F$ be the ideal in $U$ generated by the $F_\alpha$.
      $F = (F_\alpha)$ is called the {\bf Groebner family of $J$}.
      
      Any term order $>$ on the monomials of $S$, on a finite set $M$ of monomials, is given by
      a weight vector $w \in \mathbb{Z}^{n+1}$: for $x^\alpha, x^\beta \in M$, 
      $x^\alpha > x^\beta$ if and only if $w \cdot \alpha > w \cdot \beta$.  If we let 
      the weight of $t_{\alpha, \gamma}$ be $w \cdot (\alpha - \gamma)$, then with this grading,
      $F_\alpha$ is homogeneous of weight $w \cdot \alpha$.  This grading is useful for 
      performance reasons: computing with homogeneous ideals is much more efficient than with
      arbitrary ideals.  Additionally, we can order the variables $t_{\alpha, \gamma}$ by refining
      the weight degree by any term order on $T$: if the weight of $t_{\alpha, \gamma}$ is
      greater than $t_{\alpha', \gamma'}$ then $t_{\alpha, \gamma} > t_{\alpha', \gamma'}$ in this term order.
      weight.  
    Text
      @SUBSECTION "The Groebner stratum of an initial ideal"@
      
      If we consider a minimal set of syzygies of the minimal generators $x^\alpha$ of $J$,
      and we apply this syzygy to the $F_\alpha$, then take the remainder upon division
      with the $F_\alpha$, and let $L$ be the ideal generated by all of the coefficients in $T$
      of these resulting polynomials, then $L$ is called the {\bf Groebner stratum of $J$}, and
      $F = (F_\alpha)$ is called the {\bf Groebner family of $J$}.
      
      Over $\mathbb{V}(L)$, $F$ defines a flat family all of whose fibers have initial ideal $J$,
      and consequently defines via representability of the Hilbert scheme, a closed subscheme of 
      $Hilb$. These families, over all saturated monomial ideals, cover the Hilbert scheme.
    Example
      needsPackage "GroebnerStrata"
      J = B6_1
      J = ideal(a^2,a*b,b^2,a*c,b*c^2,c^3)
      F = groebnerFamily J
      U = ring F;
      T = coefficientRing U
      netList F_*
      L = trim groebnerStratum F;
      assert(dim L == 18)
      elapsedTime isPrime L 
    Text
      @SUBSECTION "The Schreyer resolution and minimal Betti numbers"@
    Text
      Schreyer's construction of a nonminimal free resolution starts with a Groebner basis.
      First, one constructs the {\bf Schreyer frame} (see La Scala, Stillman).  This is
      determined solely from the initial ideal $J$ and its minimal generators (but depends on
      some choices of ordering, but otherwise is combinatorial).  This consists of the lead
      monomials of the Groebner bases of the syzygy modules of the initial ideal $J$ (in the
      so-called induces, or Schreyer order).
  
      One then fills in the rest of each column of each matrix in this non minimal resolution
      by computing the image of the monomial, and taking its remainder with respect to all the
      lead terms at the previous homological degree (except the monomial we used).  This
      gives a nonminimal free resolution, and after the frame is made, the only operations 
      needed in the coefficient ring are subtraction and multiplication.
      
      By linear algebra, a non minimal free resolution can be made minimal by the following process:
      find a non-zero scalar entry at, say, the $(i,j)$ entry of the $\partial_k : C_k \to C_{k-1}$.
      By column operations, make all the other entries in the $i$-th row 0, then remove the
      $i$-th row, and $j$-th column of this matrix, changing the two adjacent matrices in the process.
      
      In the standard grading on $S$, the minimal free resolution will be homogeneous (with the $t$
      variables all having degree 0). For each degree $d$, there is a submatrix of the
      map $\partial^C_i \colon C_i \to C_{i-1}$, let's call it $\rho_{i,d}$.  This is a matrix defined 
      over the base field.  The ranks of these matrices determine the Betti table of the
      minimal free resolution of $S/I$.  
      
      Similarly, one can compute the non-minimal resolution of $F$, over the ring $T/L$.
      For any specialization to a point, the specialization of the complex is a non-minimal
      free resolution of the specialized point.
    Text
      There are only two Borel fixed ideals for 6 points.  Notice that
      in this particular case, the Hilbert function and generic
      initial ideal is determined by the number of quadrics in the
      saturated ideal: If there are 5 quadrics in the ideal, it has
      the first gin, and if there are 4 quadrics, it has the second gin.
      
      This means that we can partition the entire Hilbert scheme into 2 parts:
      The generic initial ideal is one of these two.
    Text
      Let $H$ be the Hilbert scheme of 6 points in ${\mathbb P}^3$.  $H$ has one component,
      is rational, and has dimension 18.  A general set of 6 points has regularity 2,
      and its free resolution is shown in the next example.
    Example
      I = pointsIdeal randomPoints(S, 6)
      degree I
      radical I == I
      betti res I
    Text
      If an ideal $I$ has initial ideal $J$, we can construct a (nonminimal in general)
      free resolution of $I$ with the same Betti table as $J$.  The Betti table
      of (the minimal free resolution of) $I$ is determined by the ranks of the degree 0
      maps in this non-minimal resolution.
    Example
        (CF, H) = nonminimalMaps F;
        U = ring CF
        CF
        betti(CF, Weights=>{1}) -- alas, it is a poor non-minimal resolution
        assert isHomogeneous CF -- but it is homogeneous, as it needs to be.
        keys H
        M1 = H#(2,3) -- rank is 0, 1, or 2.
        M2 = H#(3,4) -- rank is 1 or 2
        M3 = H#(3,5) -- maximal rank, can ignore
        M4 = H#(4,6) -- maximal rank, can ignore
    Text
        What are the possible ranks of M1, M2?  (M3, M4 are full rank).
        We check: M1 is rank 0 (on the relevant points of the parameter space)
        if and only if M2 has rank 1 (the smallest possible).
        So we need to check: (rank M1, rank M2) = (0, 1), (0,2), (1,1), (1,2), (2,1), (2,2)).
        Of these, 

    Example
        ideal M1 == minors(2, M2)
    Text
        Therefore the following cannot happen: (0, 2), (1, 1), (2, 1).  
        Therefore the possible ranks are: (0, 1), (1,2), (2,2).
        The last one means there is maximal cancellation: this happens for an open set of
        the Hilbert scheme of 6 points.  (0,1) means: no cancellation, whereas (1,2) means 

        $\phantom{WWWW}        
        \begin{matrix}
          &0&1&2&3\\
          \text{total:}&1&6&8&3\\
          \text{0:}&1&\text{.}&\text{.}&\text{.}\\
          \text{1:}&\text{.}&4&4&1\\
          \text{2:}&\text{.}&2&4&2\\
        \end{matrix},\quad
        \begin{matrix}
          &0&1&2&3\\
          \text{total:}&1&5&6&2\\
          \text{0:}&1&\text{.}&\text{.}&\text{.}\\
          \text{1:}&\text{.}&4&3&\text{.}\\
          \text{2:}&\text{.}&1&3&2\\
        \end{matrix},\quad
        \begin{matrix}
          &0&1&2&3\\
          \text{total:}&1&4&5&2\\
          \text{0:}&1&\text{.}&\text{.}&\text{.}\\
          \text{1:}&\text{.}&4&2&\text{.}\\
          \text{2:}&\text{.}&\text{.}&3&2\\
        \end{matrix}
        $
    Text
        We now compute the locus in $V(L)$ where the Betti diagram has no cancellation.
        This is a closed subscheme of $V(L)$, which is a closed subscheme of the Hilbert scheme.
        Notice that there are two components.
    Example
        L441 = trim(L + ideal M1);
        elapsedTime compsL441 = decompose L441;
        #compsL441
        compsL441/dim -- two components, of dimensions 14 and 16.
        compsL441/dim == {16, 14}
    Text
        Both components are rational, and here are random points, one on each component:
    Example  
        pta = randomPointOnRationalVariety compsL441_0
        Fa = sub(F, (vars S) | pta)
        betti res Fa
        netList decompose Fa -- this one is 5 points on a plane, and another point
        CFa = minimalPrimes Fa
        lin = CFa_1_0 -- a linear form, defining a plane.
        CFa/degree
        CFa/(I -> lin % I == 0) -- so 5 points on the plane.
        degree(Fa : (Fa : lin))  -- somewhat simpler(?) way to see the ideal of the 5 points
    Example  
        ptb = randomPointOnRationalVariety compsL441_1
        Fb = sub(F, (vars S) | ptb)
        betti res Fb
        netList decompose Fb -- 
        netList for x in subsets(decompose Fb, 3) list intersect(x#0, x#1, x#2)
    Example
        pt0 = randomPointOnRationalVariety(compsL441_0)
        pt1 = randomPointOnRationalVariety(compsL441_1)
    Text
        We compute the ideal of the corresponding zero dimensional scheme with length 6, 
        corresponding to the points pt0, pt1 in Hilb.
    Example
        I0 = sub(sub(F, (vars ring F) | sub(pt0, ring F)), S)
        I1 = sub(sub(F, (vars ring F) | sub(pt1, ring F)), S)
        betti res I0
        betti res I1
    Example
        netList decompose I0
        netList decompose I1
    Example
        L430 = (trim minors(2, M1)) + groebnerStratum F;
        --elapsedTime compsL430 = minimalPrimes(L430, Verbosity=>2);
    Example
      C = res(I, FastNonminimal => true)
      betti C
      m1 = submatrixByDegrees(C.dd_2, {3}, {3})
      m2 = submatrixByDegrees(C.dd_3, {4}, {4})
    Text
      In this example, m1 and m2 both have full rank, and therefore we can cancel
      adjacent numbers to get a minimal resolution (it must be minimal, as by
      homogeneity, there are no non-zero elements of degree 0 in the resulting
      resolution.
    Example
      minimalBetti I
    Text
      Schreyer's algorithm implies that if we have a Groebner basis of an ideal with gin $B$,
      then we can construct a nonminimal resolution of $S/I$ whose Betti table matches that
      of $B$.  This will be nonminimal, therefore can be pruned to a free resolution by 
      taking any non-zero scalars that appear as entries in the resolution, and performing
      linear algebra to remove that entry, its row and column, and the corresponding column in the previous matrix
      then we still have a free resolution.  Continuing in this way, we obtain a minimal 
      resolution.
///
