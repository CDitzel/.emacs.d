;;-*-coding: utf-8;-*-
(define-abbrev-table 'global-abbrev-table
  '(
    ("cd" "// TODO(cditzel MB):" nil :count 0)
    ("cdp" "# TODO(cditzel MB):" nil :count 0)
    ("db" "std::cout << \"==========MY_DEBUG========== \" << @@ << \"\\n\"" nil :count 0)
    ("ex" "exit(1);" nil :count 0)
    ("fr" "for(uint32_t i = 0; i < @@; ++i){}" nil :count 0)
    ("os" "std::cout << @@ << \"\\n\";" nil :count 0)
    ("pdb" "import pdb; pdb.set_trace()" nil :count 0)
    ("png" "from torchvision.utils import save_image save_image(@@.float() '.png') " nil :count 0)
    ("pr" "print(f\"{@@= }\")" nil :count 0)
    ("rr" "- [ ]" nil :count 0)
    ("vo" "(void) @@;" nil :count 0)
   ))

