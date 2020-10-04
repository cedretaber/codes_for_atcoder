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

enum P = 10L^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    char[] S; get(S);
    S = '_' ~ S;
    auto N = S.length;

    auto cs = new long[][](N, 3);
    long qc;
    foreach (i; 1..N) {
        static foreach (j; 0..3) cs[i][j] = cs[i-1][j];
        switch (S[i]) {
            case 'A': ++cs[i][0]; break;
            case 'C': ++cs[i][1]; break;
            case '?':
                ++cs[i][2];
                ++qc;
                break;
            default:
        }
    }

    long r;
    foreach (i; 1..N) {
        if (S[i] == 'B' || S[i] == '?') {
            auto a = cs[i-1][0];
            auto c = cs[$-1][1] - cs[i][1];
            auto aq = cs[i-1][2];
            auto cq = cs[$-1][2] - cs[i][2];
            auto q = qc;
            if (S[i] == '?') --q;
            (r += a * c % P * pow(3, q)) %= P;
            if (q >= 1) {
                (r += aq * c % P * pow(3, q-1)) %= P;
                (r += a * cq % P * pow(3, q-1)) %= P;
            }
            if (q >= 2) {
                (r += aq * cq % P * pow(3, q-2)) %= P;
            }
        }
    }
    writeln(r);
}

/*

Bか?を選んで、そのB/?の
  「前のAの数」 * 「後ろのCの数」 * 3^(全体の?の数)
  + 「前の?の数」 * 「後ろのCの数」 * 3^(全体の?の数-1)
  + 「前のAの数」 * 「後ろの?の数」 * 3^(全体の?の数-1)
  + 「前の?の数」 * 「後ろの?の数」 * 3^(全体の?の数-2)

A??C

A ? ? C
1*1*3^1 + 1*1*3^0 = 4
1*1*3^1 + 1*1*3^0 = 4
*/