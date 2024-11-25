program automatic util#(parameter int w = 3)();
    function void scheck(string s, logic[w:0] y, ye, integer vn);
        if(y !== ye)
            begin
                $display("%s test failed, number: %d, %b != %b", s, vn, y, ye);
                if(vn > 100)
                    begin
                        $finish;
                    end
            end
    endfunction
endprogram