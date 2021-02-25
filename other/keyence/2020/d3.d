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
    int[] AS; get(AS);
    int[] BS; get(BS);

    int r = int.max;
    auto memo = new bool[](N);
    auto ns = new int[](N);
    auto ms = new int[](N);
    foreach (x; 0..1<<N) if (popcnt(x) % 2 == 0) {
        foreach (i; 0..N) {
            auto n = (x & (1<<i)) ? BS[i] : AS[i];
            ns[i] = n;
            ms[i] = n;
        }
        sort(ns);
        int rr;
        memo[] = false;
        foreach (i; 0..N) {
            int c;
            foreach (j; 0..N) if (!memo[j]) {
                ++c;
                if (ns[i] != ms[j]) continue;
                if ((abs(j - i) % 2 == 1) != !!(x & (1<<j))) continue;
                memo[j] = true;
                rr += c - 1;
                goto ok;
            }
            goto ng;
            ok:
        }
        r = min(r, rr);
        continue;
        ng:
    }
    writeln(r == int.max ? -1 : r);
}
