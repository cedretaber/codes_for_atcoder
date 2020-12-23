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
 
alias E = Tuple!(int, "from", int, "to", long, "c");
 
void main()
{
    int N, M; long P; get(N, M, P);
    E[] es;
    foreach (_; 0..M) {
        int A, B; long C; get(A, B, C); --A; --B; C -= P;
        es ~= E(A, B, C);
    }
 
    auto DP = new long[](N);
    DP[] = long.min / 3;
    DP[0] = 0;
 
    foreach (_; 0..N) {
        foreach (e; es) if (DP[e.to] < DP[e.from] + e.c) {
            DP[e.to] = DP[e.from] + e.c;
        }
    }
 
    auto r = DP[$-1];
 
    foreach (_; 0..N) {
        foreach (e; es) if (DP[e.to] > long.min / 4 && DP[e.to] < DP[e.from] + e.c) {
            DP[e.to] = long.max / 3;
        }
    }
 
    writeln(r == DP[$-1] ? max(0, r) : DP[$-1] > r ? -1 : max(0, r));
}