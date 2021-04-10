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

enum P = 10^^9L + 7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

alias X = Tuple!(int, "i", long, "a");

void main()
{
    int N; long A, B; get(N, A, B);
    long[] aa; get(aa);
    sort(aa);

    if (A == 1) return writefln!"%(%d\n%)"(aa);
    
    X[] ps;
    foreach (i, a; aa) ps ~= X(i.to!int, a);
    auto Q = heapify!"a.a == b.a ? a.i < b.i : a.a > b.a"(ps);
    while (Q.front.i != N-1) {
        if (B == 0) {
            foreach (p; Q) writeln(p.a);
            return;
        }
        --B;
        auto p = Q.front;
        Q.popFront();
        Q.insert(X(p.i, p.a * A));
    }
    auto b = B / N;
    auto c = B % N;
    aa = Q.map!"a.a"().array();
    foreach (ref a; aa[0..c]) a = a % P * pow(A, b + 1) % P;
    foreach (ref a; aa[c..$]) a = a % P * pow(A, b) % P;
    writefln!"%(%d\n%)"(aa[c..$] ~ aa[0..c]);
}
