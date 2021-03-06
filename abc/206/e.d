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
    int L, R; get(L, R);
    long res;
    auto ps = new int[][R];
    foreach (i; 2..R) {
        if (ps[i].empty) {
            for (auto j = i * 2; j < R; j += i) ps[j] ~= i;
        } else if (i >= L) {
            long c;
            foreach (b; 1..2^^ps[i].length) {
                long x = 1;
                foreach (j, p; ps[i]) if (b & (1 << j)) x *= p;
                c += (R / x - i / x) * ((-1) ^^ popcnt(b));
            }
            if (c < 0) c = -c;
            res += c - R / i + 1;
        }
    }
    writeln(res * 2);
}

/*

  1 2 3 4 5 6 7 8 9 10
2   p   .   .   .   . 
3     p     .     .   
4       +   .   +   .  => 4
5         p         .
6           +   . . .  => 6
7             p
8               +   .  => 2
9                 +    => 0
10                  +  => 0  

*/
