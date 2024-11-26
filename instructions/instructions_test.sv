interface databus();
    reg [63:0] op1, op2;
    logic carryout;
    reg [63:0] result;
    modport Test(
        output op1, op2,
        input result, carryout
    );
    modport Instructions(
        output result, carryout,
        input op1, op2
    );
endinterface

class Transaction;
        rand bit [64:0] op1, op2;
        bit [64:0] result;
        bit [1:0] instruction;
        constraint high{
            if (instruction == 2'b00) {
                op1[63:6] == '1;
                op2[63:6] == '1;
            }
        }
        function new (bit [1:0] instruction);
            this.instruction = instruction;
        endfunction
        
        virtual function void calc();
            case(instruction)
                2'b00: result = op1 + op2;
                2'b01: result = op1 - op2;
            endcase
        endfunction
endclass

class Driver;
    mailbox gen2drv;
    databus.Test dataint;

    function new(mailbox gen2drv, databus.Test dataint);
        this.gen2drv = gen2drv;
        this.dataint = dataint;
    endfunction

    task main;
        Transaction tr;
        forever 
            begin
                gen2drv.get(tr);
                tr.calc();
                dataint.op1 = tr.op1;
                dataint.op2 = tr.op2;
            end
    endtask
endclass

module top();
    databus the_databus();
endmodule