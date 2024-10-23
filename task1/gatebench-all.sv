module testbench();
  logic [3:0] a, b, y, ynot, yand, ynand, yor, ynor, yxor, ynxor;
  logic [3:0] ye, ynote, yande, ynande, yore, ynore, yxore, ynxore; 
  logic [39:0] tv [135:0];
  integer vn = 0;
  gates g(a, b, y, ynot, yand, ynand, yor, ynor, yxor, ynxor);
  initial
    begin
      $readmemb("tests.txt", tv);
      repeat(2)
	        begin
            {a, b, ye, ynote, yande, ynande, yore, ynore, yxore, ynxore} = tv[vn];
            #10;
            if(y !== ye || ynot !== ynote || yand !== yande || ynand !== ynande || 
               yor !== yore || ynor !== ynore || yxor !== yxore || ynxor !== ynxore)
	            begin
                $display("Fail");
              end
            vn = vn + 1;
          end
      $finish;
    end
endmodule;
