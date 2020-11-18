import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;
import core.bitop;

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
    int N; get(N);
    int[] AS; get(AS);

    alias I = Tuple!(int, "i", int, "a");
    auto as = new I[](2^^N);
    as[0] = I(0, AS[0]);
    auto bs = new I[](2^^N);
    bs[0] = I(0, AS[0]);
    auto res = new int[](2^^N);
    foreach (x; 1..2^^N) {
        auto ii = heapify!"a.a < b.a"([I(0, AS[0]), I(x, AS[x])]);
        auto memo = [0: true, x: true];
        int max_r;
        foreach (i; 0..N) if (x & (1<<i)) {
            auto y = (x & (~(1<<i)));
            max_r = max(max_r, res[y | ((1<<i)-1)]);
            auto a = as[y], b = bs[y];
            if (a.i !in memo) {
                ii.insert(a);
                memo[a.i] = true;
            }
            if (b.i !in memo) {
                ii.insert(b);
                memo[b.i] = true;
            }
        }
        as[x] = ii.front;
        ii.popFront();
        bs[x] = ii.front;
        res[x] = max(max_r, as[x].a + bs[x].a);
    }
    writefln!"%(%d\n%)"(res[1..$]);
}