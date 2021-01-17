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
    int N; get(N);
    char[] S, T; get(S); get(T);
    auto a = T[0];
    auto b = T[1];
    auto c = T[2];

    if (a == b && b == c) {
        int r, x;
        foreach (s; S) {
            if (s == a) {
                ++x;
            } else {
                r += x / 3;
                x = 0;
            }
        }
        writeln(r + x / 3);
    } else if (a == b || b == c) {
        if (b == c) {
            S.reverse();
            swap(a, c);
        }
        int r, x;
        foreach (s; S) {
            if (s == a) {
                ++x;
            } else if (s == c && x >= 2) {
                ++r;
                x -= 2;
            } else {
                x = 0;
            }
        }
        writeln(r);
    } else if (a == c) {
        S ~= 'X';
        int[] cs;
        int x, r;
        foreach (s; S) {
            if (s == a) {
                ++x;
            } else if (s == b && x > 0) {
                cs ~= x;
                x = 0;
            } else {
                if (x) cs ~= x;
                x = 0;
                while (cs.length > 1 && cs.any!"a != 1") {
                    int[] css;
                    foreach (i; 0..cs.length) {
                        if (cs[i] == 1) {
                            css ~= 1;
                        } else if (i == cs.length-1) {
                            css = css[0..$-1];
                            css ~= cs[i] - 1;
                            ++r;
                            break;
                        } else {
                            css ~= cs[i] + cs[i+1] - 2;
                            foreach (j; i+2..cs.length) css ~= cs[j];
                            ++r;
                            break;
                        }
                    }
                    cs = css;
                }
                r += cs.length.to!int / 2;
                cs = [];
            }
        }
        writeln(r);
    } else {
        auto memo = SList!int();
        int r;
        foreach (s; S) {
            if (s == a) {
                memo.insert(1);
            } else if (s == b && !memo.empty && memo.front == 1) {
                memo.removeFront();
                memo.insert(2);
            } else if (s == c && !memo.empty && memo.front == 2) {
                ++r;
                memo.removeFront();
            } else {
                memo.clear();
            }
        }
        writeln(r);
    }
}

/*

6
ababaa
aba

101 010 101 010 101 101


abababababccccc

aabaabaabaabcbccbccbccbc

abc -> 貪欲 A,B,C のポジションの列をメモ
aaa -> 貪欲 A が連続する位置を3で割る

aab -> 貪欲、 メモするのは A,B の数
aba
abb -> reverse


9
aaaababab
aab

7
aaabaxb
aab

6
ababaa
aba

6
ababca
aba

abababa

1,1,1,1


ababaa

aababa

abaaba

aababa
aabaababa

2,2,1,1 -> 2,1,1 -> 1,1


15
aaaaaababababab
aba

*/