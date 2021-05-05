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

import std.random;

void main()
{
    int N; get(N);
    if (N == 1) {
        int[] abc; get_lines(3, abc);
        writeln(abc[0] * abc[1] == abc[2] ? "YES" : "NO");
    } else {
        int[][] A, B, C; get_lines(N, A); get_lines(N, B); get_lines(N, C);
        auto r = new int[](N);
        auto a = new int[](N);
        auto b = new int[](N);
        auto c = new int[](N);
        foreach (_; 0..100) {
            foreach (i; 0..N) r[i] = uniform(0, 2);
            a[] = 0;
            b[] = 0;
            c[] = 0;
            foreach (i; 0..N) foreach (j; 0..N) b[i] += B[i][j] * r[j];
            foreach (i; 0..N) foreach (j; 0..N) a[i] += A[i][j] * b[j];
            foreach (i; 0..N) foreach (j; 0..N) c[i] += C[i][j] * r[j];

            if (a != c) return writeln("NO");
        }
        writeln("YES");
    }
}
