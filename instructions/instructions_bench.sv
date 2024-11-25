// // typedef enum { 
// //     ADDU = 2'b00,
// //     SUBU = 2'b01
// // } instruction_t;

// program automatic testinstructions(databus.Test dataint, controlbus.Test controlint);

//     class Test_ADD;
//         rand bit [63:0] op1, op2;
//         constraint high{
//             if (controlint.instruction == 2'b00) {
//                 op1[63:6] == '1;
//                 op2[63:6] == '1;
//             }
//         }
//     endclass;

//     initial
//         begin
//             Test_ADD numbers;
//             numbers = new;
//             repeat(10)
//                 begin
//                     numbers.randomize();
//                     dataint.op1 = numbers.op1;
//                     dataint.op2 = numbers.op2;
//                     controlint.enable = 1'b1;
//                     controlint.reset = 1'b0;
//                     controlint.instruction = 2'b00;
//                     $display("ADD Op1: %b, Op2: %b, result: %b, carryout: %b", dataint.op1, dataint.op2, dataint.result, dataint.carryout);
//                 end
//         end
// endprogram

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

class BedTr extends Transaction;
    rand bit bed_result;
    virtual function void calc();
        super.calc();
        if (bed_result) result = ~result;
    endfunction
endclass

class Generator;
    Transaction tr;
    mailbox gen2drv;

    function new(mailbox gen2drv);
        this.gen2drv = gen2drv;
        this.tr = new;
    endfunction

    task run;
        Transaction test;
        forever
            begin
                tr.randomize();
                test = tr.copy();
                gen2drv.put(test);
            end
    endtask
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

class Environment;
    Driver d;
    Generator g;
    mailbox gen2drv;

    function new (databus.Test dataint);
        gen2drv = new;
        d = new(gen2drv, dataint);
        g = new(gen2drv);
    endfunction

endclass

module top();
    // logic clk = 0;

    // always
    //     begin
    //         #5;
    //         clk = ~clk;
    //     end

    // type_instruction the_type_instruction;
    databus the_databus();
    controlbus the_controlbus();
    instructions the_instructions(the_databus.Instructions, the_controlbus.Instructions);
    testinstructions the_testinstructions(the_databus.Test, the_controlbus.Test);

endmodule