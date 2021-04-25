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
    int N, K, C; get(N, K, C);
    char[] S; get(S);

    int k, c;
    auto ll = new int[](N);
    foreach (i; 0..N) {
        --c;
        if (c <= 0 && S[i] == 'o') {
            ll[i] = ++k;
            c = C + 1;
        }
        if (k == K) break;
    }
    k = K; c = 0;
    auto rr = new int[](N);
    foreach_reverse (i; 0..N) {
        --c;
        if (c <= 0 && S[i] == 'o') {
            rr[i] = k--;
            c = C + 1;
        }
        if (k == 0) break;
    }
    foreach (i; 0..N) if (ll[i] != 0 && ll[i] == rr[i]) writeln(i + 1);
}
