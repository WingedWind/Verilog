program automatic random_test();
    class Paket;
        bit [7:0] x;
        rand bit [7:0] y;
        rand bit [31:0] z;
        constraint c{
            y > 3;
            y < 9;
            if (x > 5) {
                z inside{0, [2:10], [100:107]};
            }
            (x > 15) -> z[0] == 1'b1;
        } 
    endclass;

    class Packet_a;
        rand bit [15:0] a, b, c;
        constraint c1{
            0 < a;
        }
        constraint c2{
            a < b;
        }
        constraint c3{
            b < c;
        }
    endclass;

    class Packet_b;
        int low, high;
        rand int c;
        constraint range{
            !(c inside {[low:high]});
            c > 0;
        }
        function new;
            low = 15;
            high = 150;
        endfunction
    endclass;

    class Packet_c;
        rand int x, y;
        int p1, p2;
        function new;
            p1 = 40;
            p2 = 60;
        endfunction
        constraint c{
            x dist {0:=p1, [1:3]:=p2};
            y dist {0:/p1, [1:3]:/p2};
        }
    endclass;

    class Packet_d;
        rand bit x; // 0 or 1;
        rand bit [1:0] y;

        constraint xy{
            // y > 0;
            (x == 0) -> y == 0;
            solve x before y;
        }
    endclass;
    
    initial
        begin
            Paket p, q;
            p = new;
            p.x = 1;
            q = p;
            $display("%b", q.x);
            q.x = 2;
            $display("%b %b", p.x, p.y);
            p.randomize();
            $display("%b %b %b", p.x, p.y, p.z);
            p.x = 17;
            p.randomize();
            $display("%b %b %b", p.x, p.y, p.z);
        end
    
    initial
        begin
            Packet_a p;
            Packet_b p_b;
            Packet_c p_c;
            Packet_d p_d;
            #10;
            p = new;
            p.randomize();
            $display("%b %b %b", p.a, p.b, p.c);
            p.c3.constraint_mode(0);
            p.randomize();
            $display("%b %b %b", p.a, p.b, p.c);
            p.constraint_mode(0);
            p.randomize();
            $display("%b %b %b", p.a, p.b, p.c);

            // p_b = new;
            // p_b.randomize();
            // $display("%d, %d, %d", p_b.low, p_b.high, p_b.c);
            
            // p_c = new;
            // repeat(20)
            //     begin
            //         p_c.randomize();
            //         $display("%d, %d", p_c.x, p_c.y);
            //     end

            // p_d = new;
            // repeat(20)
            //     begin
            //         p_d.randomize();
            //         $display("%b, %b", p_d.x, p_d.y);
            //     end

        end
endprogram

module top();
    random_test the_test();
endmodule