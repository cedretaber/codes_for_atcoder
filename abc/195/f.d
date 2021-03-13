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
    long A, B; get(A, B);
    long[] x2s, x3s, x6s, xs;
    bool has_one;
    foreach (x; A .. B + 1) {
        if (x == 1) {
            has_one = true;
        } else if (x % 6 == 0) {
            x6s ~= x;
        } else if (x % 3 == 0) {
            x3s ~= x;
        } else if (x % 2 == 0) {
            x2s ~= x;
        } else {
            xs ~= x;
        }
    }

    long r1 = x2s.length + x3s.length + x6s.length;
    foreach (x2; x2s) foreach (x3; x3s) if (gcd(x2, x3) == 1) ++r1;
    if (has_one) r1 *= 2;

    ulong[] make_xr(long[] xx) {
        auto xr = new ulong[](xs.length);
        foreach (i; 0..xs.length) {
            ulong b;
            foreach (j; 0..xx.length) if (gcd(xs[i], xx[j]) != 1) b |= 1L<<j;
            xr[i] = b;
        }
        return xr;
    }
    auto xr = make_xr(xs);
    auto x2r = make_xr(x2s);
    auto x3r = make_xr(x3s);
    auto x6r = make_xr(x6s);

    auto x23r = new ulong[](x2s.length);
    foreach (i, x2; x2s) {
        ulong b;
        foreach (j, x3; x3s) if (gcd(x2, x3) != 1) b |= 1L<<j;
        x23r[i] = b;
    }

    long r2;
    foreach (b; 1..(1L<<xs.length)) {
        ulong f2, f3, f6;
        foreach (i; 0..xs.length) if (b & (1L<<i)) {
            if ((b & xr[i]) != (1L<<i)) goto ng;
            f2 |= x2r[i];
            f3 |= x3r[i];
            f6 |= x6r[i];
        }
        r2 += 1 + x6s.length - popcnt(f6) + x3s.length - popcnt(f3) + x2s.length - popcnt(f2);
        foreach (i; 0..x2s.length) if (!(f2 & (1L<<i))) {
            r2 += x3s.length - popcnt(x23r[i] | f3);
        }
        ng:
    }
    if (has_one) r2 *= 2;f
    writeln(r1 + r2 + (has_one ? 2 : 1));
}

/*

2 3 4 5


2 4
3
5

2 3 5
4 3 5
3 5
2 5
4 5
5
2 3
4 3
2
4
3

*/
