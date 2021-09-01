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

enum P = 998244353L;

void main()
{
    long N; get(N);
    long r;
    for (long q = 1; q ^^ 2 <= N; ++q) {
        auto m = N / q;
        if (m < q) continue;
        (r += (m - q + 2) / 2) %= P;
    }
    writeln(r);
}

/*

y = x^2 - n^2
  = (x + n)(x - n)

x + n = p, x - n = q と置く。
- p > q
- (p - q) / 2 = n で整数
- 1 <= x = (p + q) / 2 <= N
- 1 <= y = p * q <= N

以上から、
- p, q は整数
- q を固定した時、 p の値は q <= p <= N / q かつ (p + q) % 2 = 0
p = q の時が q の最大値なので、 0 - √N まで調べる

*/
