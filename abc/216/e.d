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
    int N; long K; get(N, K);
    long[] AA; get(AA);
    sort!"a > b"(AA);

    long w, h = AA[0], n, r;
    int i;
    while (K > 0 && i < N) {
        while (i < N && AA[i] == h) {
            ++w;
            ++i;
        }
        n = i == N ? 0 : AA[i];
        auto x = w * (h - n);
        if (x <= K) {
            r += w * (h * (h + 1) / 2 - n * (n + 1) / 2);
            h = n;
            K -= x;
        } else {
            auto m = K / w;
            r += w * (h * (h + 1) / 2 - (h - m) * (h - m + 1) / 2);
            h -= m;
            r += h * (K % w);
            K = 0;
        }
    }
    writeln(r);
}
