// Bruno Ferreira Coelho - 92559
// Matricula em octal => 264617
//
// Estados:
//
// q0 = 2
// q1 = 6
// q2 = 4
// q3 = 7
// q4 = 1
//
// Diagrama da máquina de estados
// +---------------------------------------+
// |                                       |
// |                  +-----------------+  |
// |                  |                1|  |
// |            +-----+              1  |  |
// |            |    0| +-------------+ |  |
// |            |     ▼ ▼            0| ▼  |
// | +---+   +---+   +---+   +---+   +---+ |
// | | q0|   | q2|   | q1|   | q3|   | q4| |
// | +---+   +---+   +---+   +---+   +---+ |
// |  ▲ |     ▲       ▲ |     ▲ |          |
// |  | |    0|1      | |    0| |          |
// |  | +-----+       | +-----+ |          |
// |  |               |       1 |          |
// |  |0              |1        |          |
// |  +-------------------------+          |
// |                                       |
// +---------------------------------------+

module ff ( input data, input c, input r, output q);
    
    reg q;

    always @(posedge c or negedge r) 
    begin
        if (r == 1'b0)
            q <= 1'b0; 
        else 
            q <= data; 
    end 

endmodule // End module ff

// ----   FSM alto nível com Case
module statem(clk, reset, a, saida);

    input clk, reset, a;
    output [2:0] saida;
    reg [2:0] state;

    parameter q0 = 3'd2, q1 = 3'd6, q2 = 3'd4, q3 = 3'd7, q4 = 3'd1;

    assign saida =  (state == q0) ? 3'd2:
                    (state == q1) ? 3'd6:
                    (state == q2) ? 3'd4:
                    (state == q3) ? 3'd7:
                                    3'd1;

    always @(posedge clk or negedge reset)
    begin
        if (reset==0)
            state = q0;
        else
            case (state)
                q0: state = q2; 
                q1: state = q3;
                q2: state = (!a) ? q1 : q4;
                q3: state = (!a) ? q0 : q2;
                q4: state = q1;
            endcase
        /*
            +--------+
            |E | 0| 1|
            +--------+
            |q0|q2|q2|
            |q1|q3|q3|
            |q2|q1|q4|
            |q3|q0|q2|
            |q4|q1|q1|
            +--------+
        */
    end
endmodule

// FSM com portas logicas
module statePorta(input clk, input res, input a, output [2:0] saida);

    wire [2:0] state;
    wire [2:0] p;

    wire b, c, d;

    assign b = state[2];
    assign c = state[1];
    assign d = state[0];

    assign saida = state;
    
    assign p[0] = (a & b & ~d) | (b & c & ~d);             // 6 portas lógicas
    assign p[1] = (~a & b) | (b & c & ~d) | (~c & d);  // 8 portas lógicas
    assign p[2] = (~b) | (~a & ~d) | (a & c);      // 8 portas lógicas
    
    // Total de 22 portas lógicas

    ff  e0(p[0], clk, res, state[0]);
    ff  e1(p[1], clk, res, state[1]);
    ff  e2(p[2], clk, res, state[2]);

endmodule // End Module statePorta

module stateMem(input clk,input res, input a, output [2:0] saida);

    reg [5:0] StateMachine [0:15]; // 16 linhas e 6 bits de largura
    initial
    begin
	StateMachine[0] = 6'd34;
        StateMachine[1] = 6'd49;
        StateMachine[2] = 6'd34;
        StateMachine[3] = 6'd34;
       	StateMachine[4] = 6'd52;
        StateMachine[5] = 6'd34;
        StateMachine[6] = 6'd62;
        StateMachine[7] = 6'd23;
	    StateMachine[8] = 6'd34;
        StateMachine[9] = 6'd49;
        StateMachine[10] = 6'd34;
        StateMachine[11] = 6'd34;
        StateMachine[12] = 6'd12;
        StateMachine[13] = 6'd34;
        StateMachine[14] = 6'd62;
        StateMachine[15] = 6'd39;
    end
    
    wire [3:0] address; // 16 linhas = 4 bits de endereco
    wire [5:0] dout; 	// 6 bits de largura 3+3 = proximo estado + saida
    
    assign address[3] = a;
    assign dout = StateMachine[address];
    assign saida = dout[2:0];
    
    ff st0(dout[3], clk, res, address[0]);
    ff st1(dout[4], clk, res, address[1]);
    ff st2(dout[5], clk, res, address[2]);

endmodule

module main;

    reg c,res,a;
    wire [2:0] saida;
    wire [2:0] saida1;
    wire [2:0] saida2;

    statem FSM(c, res, a, saida);
    stateMem FSM1(c, res, a, saida1);
    statePorta FSM2(c, res, a, saida2);

    initial
        c = 1'b0;
    always
        c= #(1) ~c;

    // visualizar formas de onda usar gtkwave out.vcd
    initial
    begin
        $dumpfile ("out.vcd"); 
        $dumpvars; 
    end 

    initial
    begin
        $monitor($time," c %b res %b a %b s %d smem %d sporta %d",c,res,a,saida,saida1,saida2);
        #1 res=0; a=0;
        #1 res=1;
        #8 a=1;
        #16 a=0;
        #12 a=1;
        #4;
        $finish ;
    end

endmodule
