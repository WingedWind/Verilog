typedef enum { 
    ADDU = 2'b00,
    SUBU = 2'b01
} instruction_t;


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

interface controlbus();
    logic reset, enable;
    instruction_t instruction;
    modport Test(
        output reset, enable, instruction
    );
    modport Instructions(
        input reset, enable, instruction
    );
endinterface

module instructions(databus.Instructions dataint, controlbus.Instructions controlint);
    always_comb
        begin
            if (controlint.reset)
                dataint.result <= 'h0;
            else
                if (controlint.enable)
                    begin
                        case(controlint.instruction)
                            ADDU: 
                                begin
                                    dataint.result <= dataint.op1 + dataint.op2;
                                    databus.carryout = dataint.op1[0] & dataint.op2[0];
                                end
                            SUBU:
                                begin
                                    dataint.result <= dataint.op1 - dataint.op2;
                                    databus.carryout = dataint.op1[0] < dataint.op2[0];
                                end
                        endcase
                    end
        end
endmodule