import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

void main()
{

}

/*

(a+b) + (a+c) + (b+c)


a b c

(a+b) + (a+c) + (b+c)
=> 2a + 2b + 2c
((a+b) + (a+c) + (b+c))^2
=> (a+b)^2 + (a+c)^2 + (b+c)^2 + 2(a+b)(a+c) + 2(a+b)(b+c) + 2(a+c)(b+c)

(a+b)^2 + (a+c)^2 + (b+c)^2
a^2 + 2ab + b^2 + a^2 + 2ac + c^2 + b^2 + 2bc + c^2
=> 2a^2 + 2b^2 + 2c^2 + 2ab + 2ac + 2bc


(a+b)^3 + (a+c)^3 + (b+c)^3
=> 2a^3 + 2b^3 + 2c^3 + 3a^2b + 3ab^2 + 3a^2c + 3ac^2 + 3b^2c + 3bc^2


10 10
1 1 1 1 1 1 1 1 1 1
9*10
9*10*2

Sum[ (A_i + A_i+1)^x + (A_i + A_i+2)^x + ... (A_i + A_N)^x ]

*/