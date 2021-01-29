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

alias C = Tuple!(int, "i", int, "n");

void main()
{
    int N; get(N);
    int[] AS, BS; get(AS); get(BS);
    C[] cs;
    foreach (i, b; BS) cs ~= C(i.to!int, b);

    auto Q = heapify!"a.n < b.n"(cs);
    long cnt;
    while (!Q.empty) with (Q.front) {
        Q.popFront();
        if (BS[i] == AS[i]) continue;
        if (BS[i] < AS[i]) return writeln(-1);

        auto x = BS[(N + i - 1) % N] + BS[(i + 1) % N];
        cnt += (n - AS[i]) / x;
        n = (n - AS[i]) % x + AS[i];
        if (n == BS[i]) return writeln(-1);
        BS[i] = n;
        if (BS[i] != AS[i]) Q.insert(C(i, n));
    }
    writeln(cnt);
}

/*

3
1 1 1
13 5 7

1 5 7

1 5 1

1 3 1

1 1 1



5
5 6 5 2 1
9817 1108 6890 4343 8704

5 1108 6890 4343 8704
5 1108 6890 4343 4356
5 1108 1439 4343 4356
5 1108 1439 4343 8
5 1108 1439 2896 8
5 1108 1439 1449 8
5 1108 1439 2 8
5 1108 329 2 8
5 774 329 2 8
5 440 329 2 8
5 106 329 2 8
5 106 221 2 8
5 106 113 2 8
5 106 5 2 8
5 96 5 2 8
5 86 5 2 8
5 76 5 2 8
5 66 5 2 8
5 56 5 2 8
5 46 5 2 8
5 36 5 2 8
5 26 5 2 8
5 16 5 2 8
5 6 5 2 8
5 6 5 2 1
*/