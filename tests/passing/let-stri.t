Special let-in constructs should be intended similarly to regular let-in
and consistently with their structure item form.
See a standard let-in for reference:

  $ cat > test.ml << EOF
  > let
  > x
  > =
  > 2
  > 
  > let x =
  > let
  > y
  > =
  > 2
  > in
  > y + 2
  > EOF

  $ ocp-indent test.ml
  let
    x
    =
    2
  
  let x =
    let
      y
      =
      2
    in
    y + 2

1. let module _ in (inconsistent with the stri)

  $ cat > test.ml << EOF
  > module
  > M
  > =
  > struct
  > let x = 2
  > end
  > 
  > let x =
  > let
  > module
  > M
  > =
  > struct
  > let x = 2
  > end
  > in
  > M.map
  > EOF

  $ ocp-indent test.ml
  module
    M
  =
  struct
    let x = 2
  end
  
  let x =
    let
      module
      M
    =
    struct
      let x = 2
    end
    in
    M.map

2. let open _ in:

  $ cat > test.ml << EOF
  > open
  > M
  > 
  > let x =
  > let
  > open
  > M
  > in
  > M.x
  > EOF

  $ ocp-indent test.ml
  open
    M
  
  let x =
    let
      open
        M
    in
    M.x

3. let exception _ in (inconsistent with stri):

  $ cat > test.ml << EOF
  > exception
  > E
  > of
  > int
  > 
  > let x =
  > let
  > exception
  > E
  > of
  > int
  > in
  > try 0 with E i -> i
  > EOF

  $ ocp-indent test.ml
  exception
    E
    of
      int
  
  let x =
    let
      exception
      E
      of
        int
    in
    try 0 with E i -> i
