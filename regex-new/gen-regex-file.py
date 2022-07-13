from io import StringIO
import numpy as np
import sys

def decl_mat(out, N, letter):
    for i in range(N+1):
        for j in range(i,N+1):
            out.write(f" ({letter}_{i}_{j} Bool)")
            
def child(out,N,k,letter):
    out.write(f"(R.Sem t{k}")
    for i in range(N):
        out.write(f" s_{i}")
        
    for i in range(N+1):
        for j in range(i,N+1):
            out.write(f" {letter}_{i}_{j}")
    
    out.write(")")

def lhs_leaf(out,N,mapp):
    for i in range(N+1):
        for j in range(i,N+1):
            out.write(f" (= X_{i}_{j} {mapp(i,j)})")
            
def recurse_sum_tree(n,head,arr):
    for i in range(1,n+1):
        inner = head + [i]
        r = n-i
        if r > 0:
            recurse_sum_tree(r,inner,arr)
        else:
            arr.append(inner)

def indexify(skips,start):
    k = 0
    ret = []
    for i in skips:
        a = start + k
        k += i
        b = start+k
        ret.append((a,b))
    return ret

def get_disjuncts(row,col):
    arr = []
    recurse_sum_tree(col-row,[],arr)
    return [indexify(m,row) for m in arr]

def gen_regex_file(N,C):
    out = StringIO()

    out.write("""(declare-term-types
    ;; Nonterminals
    ((Start 0) (R 0))
    
    ;; Productions
    (
        (($eval($eval_1 R)))
    
        (
            ($eps)
            ($phi)
            """)
    for c in range(1,C+1):
        out.write(f"($char_{c})")
        out.write("""
                """)
    out.write("""($any)
            ($or ($or_1 R) ($or_2 R))
            ($concat ($concat_1 R) ($concat_2 R))
            ($star ($star_1 R))
        )
    )
)

(define-funs-rec
    (
        (Start.Sem ((t Start)""")

    for i in range(N):
        out.write(f" (s_{i} Int)")

    out.write(""" (result Bool)) Bool)
        (R.Sem ((t R)""")

    for i in range(N):
        out.write(f" (s_{i} Int)")

    decl_mat(out, N, "X")

    out.write(""") Bool)
    )
    
    (
        (! (match t (
            (($eval t1) (exists
                (""")

    decl_mat(out,N,"X")
    out.write(""")
                (and
                    """)

    child(out,N,1,"X")
    out.write("""
                    (= result """)
    out.write(f"X_0_{N}")

    out.write(""")
                )
            ))
        )) :input (""")
    for i in range(N):
        out.write(f" s_{i}")

    out.write(""") :output (result))
        (! (match t (
            ($eps (and """)

    lhs_leaf(out,N,lambda i,j: "true" if i == j else "false")
    out.write("""))
            ($phi (and """)
    lhs_leaf(out,N,lambda i,j: "false")
    out.write("""))
            ($any (and """)
    lhs_leaf(out,N,lambda i,j: "true" if i+1 == j else "false")
    out.write("""))
    """)

    for c in range(1, C+1):
        out.write(f"            ($char_{c} (and ")
        lhs_leaf(out,N,lambda i,j: "false" if i+1 != j else f"(= s_{i} {c})")
        out.write("""))
    """)

    out.write("""            (($or t1 t2)
                (exists
                    (
                        """)
    decl_mat(out, N, "A")
    out.write("""
                        """)
    decl_mat(out,N,"B")
    out.write("""
                    )
                    (and 
                        """)
    child(out,N,1,"A")
    out.write("""
                        """)
    child(out,N,2,"B")
    out.write("""
                        (and""")
    for i in range(0,N+1):
        for j in range(i,N+1):
            out.write("""
                            """)
            out.write(f"(= X_{i}_{j} (or A_{i}_{j} B_{i}_{j}))")

    out.write("""
                        )
                    )
                )
            )
            (($concat t1 t2)
                (exists
                    (
                        """)
    decl_mat(out, N, "A")
    out.write("""
                        """)
    decl_mat(out,N,"B")
    out.write("""
                    )
                    (and 
                        """)
    child(out,N,1,"A")
    out.write("""
                        """)
    child(out,N,2,"B")
    out.write("""
                        (and
                            """)
    for i in range(0,N+1):
        out.write(f"(= X_{i}_{i} (and A_{i}_{i} B_{i}_{i})")
        out.write(""")
                            """)
        for j in range(i+1,N+1):
            out.write(f"(= X_{i}_{j} (or")
            for k in range(i,j+1):
                out.write(f" (and A_{i}_{k} B_{k}_{j})")
            out.write("""))
                            """)
    out.write("""
                        )
                    )
                )
            )
            (($star t1)
                (exists
                    (
                        """)
    decl_mat(out,N,"A")
    out.write("""
                    )
                    (and 
                        """)
    child(out,N,1,"A")
    out.write("""
                        
                        (and""")

    for i in range(0,N+1):
        out.write("""
                        """)
        out.write(f"(= X_{i}_{i} true)")
        out.write("""
                        """)
        
        if i < N:
            out.write(f"(= X_{i}_{i+1} A_{i}_{i+1})")
            out.write("""
                        """)
        
        for j in range(i+2, N+1):
            out.write(f"(= X_{i}_{j} (or")
            for group in reversed(get_disjuncts(i,j)):
                if len(group) == 1:
                    (k,l) = group[0]
                    out.write(f" A_{k}_{l}")
                else:
                    out.write(" (and")
                    for (k,l) in group:
                        out.write(f" A_{k}_{l}")
                    out.write(")")
            out.write("""))
                        """)
            
    out.write("""
                        )
                    )
                )
            )
        )) :input (""")

    for i in range(0,N):
        out.write(f" s_{i}")
    out.write(""") :output (""")

    for i in range(0,N+1):
        for j in range(i,N+1):
            out.write(f" X_{i}_{j}")

    out.write("""))
    )
)

(synth-fun match_regex() Start)

(constraint (Start.Sem match_regex""")
    for i in range(N):
        out.write(f" {0}")
    out.write(""" false))

(check-synth)
""")
    return out.getvalue()

if len(sys.argv) != 3:
    print("This script generates a Semgus grammar for regular expressions on strings of a fixed length.")
    print("Usage: gen-regex-file str_len num_chars")

N = int(sys.argv[1])
C = int(sys.argv[2])
print(gen_regex_file(N,C))