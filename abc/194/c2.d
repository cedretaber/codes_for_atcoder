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
    long N; get(N);
    long[] AS; get(AS);
    long x, y;
    foreach (a; AS) {
        x += a^^2;
        y += a;
    }
    writeln(N * x - y^^2);
}

/*

∑[i=2 -> N]∑[j=i-1 -> i-1](A_i - A_j)^2
(A_i - A_j)^2 = (A_j - A_i)^2 より、
=> ∑[i=1 -> N-1]∑[j=i+1 -> N](A_i - A_j)^2
i = j の時、 (A_i - A_j)^2 = 0 より、
=> 1/2∑[i=1 -> N]∑[j=1 -> N](A_i - A_j)^2
=> 1/2∑[i=1 -> N]∑[j=1 -> N](A_i^2 + A_j^2 + 2A_iA_j)
=> 1/2N∑[i=1 -> N]A_i^2 + 1/2N∑[j=1 -> N]A_j^2 - ∑[i=1 -> N]∑[j=1 -> N]A_iA_j
=> N∑[i=1 -> N]A_i^2 - (∑[i=1 -> N]A_i)^2

*/
