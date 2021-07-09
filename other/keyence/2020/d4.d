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

import core.bitop;

void main()
{
    int N; get(N);
    int[] AA, BB; get(AA); get(BB);

    auto res = int.max;
    auto aa = new int[](N);
    auto bb = new int[](N);
    foreach (b; 0..2^^N) if (popcnt(b) % 2 == 0) {
        foreach (i; 0..N) {
            auto x = ((b & (1 << i)) ? BB : AA)[i];
            aa[i] = x;
            bb[i] = x;
        }
        sort(bb);
        int r;
        auto memo = new bool[](N);
        foreach (i; 0..N) {
            int c;
            foreach (j; 0..N) if (!memo[j]) {
                ++c;
                if (bb[i] != aa[j]) continue;
                if (!!(abs(j - i) & 1) != !!(b & (1 << j))) continue;
                memo[j] = true;
                r += c - 1;
                goto ok;
            }
            goto ng;
            ok:
        }
        res = min(res, r);
        ng:
    }
    writeln(res == int.max ? -1 : res);
}
