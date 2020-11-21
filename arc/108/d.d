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

long P = 10^^9+7;

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
    int N; get(N);
    uint R;
    R |= readln.chomp == "A" ? 0b0001 : 0;
    R |= readln.chomp == "A" ? 0b0010 : 0;
    R |= readln.chomp == "A" ? 0b0100 : 0;
    R |= readln.chomp == "A" ? 0b1000 : 0;

    if (N <= 3 || ((R&0b0001) && (R&0b0010)) || (!(R&0b0010) && !(R&0b1000))) {
        writeln(1);
    } else if ((!(R&0b0001) && (R&0b0010) && (R&0b0100)) || (!(R&0b0010) && !(R&0b0100) && (R&0b1000))) {
        auto F = new long[](N-1);
        F[0] = 1;
        F[1] = 1;
        foreach (i; 2..N-1) F[i] = (F[i-1] + F[i-2]) % P;
        writeln(F[N-2]);
    } else {
        writeln(pow(2, N-3));
    }
}

/*

AA -> AAA, ABA
AB -> AAB, ABB
BA -> BAA, BBA
BB -> BAB, BBB

AB -> AAB, AA -> AAA
AB -> ABB, BB -> BBB

---

AA -> ABA
AB -> AAB
BA -> BAA

AB -> AAB -> ABAB, AAAB
A...AB の並びで、 AA, AB, BA は作れても BB は作れない

  0 1 2 3 4
A 1 1 2 3 5 ...
B 0 1 1 2 3 ...
=> フィボナッチ数列

AB -> ABB
BA -> BBA
BB -> BAB

--

AA -> ABA
AB -> AAB
BA -> BBA
BB -> BAB, BBB

A...AB の並びで全てのものを実現可能
AAA...AAAB とAを満たす。
任意の箇所にBを挿入する。

AAAAAAB
AA -> ABA を適用 AAABAAAB
BA -> BBA を適用 AAABBBAAAB

よって、 2^(N-3) 通り

AB -> ABB
BA -> BAA
BB -> BAB

同様

*/