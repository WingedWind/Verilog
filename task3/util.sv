program automatic util#(parameter int w = 3)();
    function void scheck(string s, logic[w:0] y, ye);
        if(y !== ye)
            begin
                $display("%s test failed, %b != %b", s, y, ye);
                $finish;
            end
    endfunction
endprogram