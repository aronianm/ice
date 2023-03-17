# Pin npm packages by running ./bin/importmap

pin "application", preload: true

pin "datatables.net", to: "https://ga.jspm.io/npm:datatables.net@1.13.3/js/jquery.dataTables.mjs"
pin "datatables.net-bs5"          , to: "https://cdn.datatables.net/1.13.1/js/dataTables.bootstrap5.mjs"
pin "datatables.net-buttons"      , to: "https://cdn.datatables.net/buttons/2.3.2/js/dataTables.buttons.mjs"
pin "datatables.net-buttons-bs5"  , to: "https://cdn.datatables.net/buttons/2.3.2/js/buttons.bootstrap5.mjs"
pin "datatables.net-buttons-html5", to: "https://cdn.datatables.net/buttons/2.3.2/js/buttons.html5.mjs"
pin "pdfmake"                     , to: "https://ga.jspm.io/npm:pdfmake@0.2.6/build/pdfmake.js"
pin "pdfmake-fonts"               , to: "https://ga.jspm.io/npm:pdfmake@0.2.6/build/vfs_fonts.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.4/dist/jquery.js"
