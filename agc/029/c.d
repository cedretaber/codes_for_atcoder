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
    int[] AS; get(AS);

    if (0.iota(N-1).all!(i => AS[i] < AS[i+1])) {
        writeln(1);
        return;
    }

    int l, r = N;
    while (l+1 < r) {
        auto m = (l+r)/2;

        int b;
        alias P = Tuple!(int, "k", int, "c");
        auto s = redBlackTree!"a.k < b.k"(P(-1, 0));

        bool incr(int k) {
            auto er = s.equalRange(P(k, 0));
            if (er.empty) {
                s.insert(P(k, 1));
            } else if (er.front.c < m) {
                auto c = er.front.c;
                s.remove(er);
                s.insert(P(k, c + 1));
            } else if (k == 1) {
                return false;
            } else {
                s.remove(er);
                return incr(k-1);
            }
            return true;
        }

        foreach (a; AS) {
            if (a > b) {
                s.remove(s.upperBound(P(b, 0)));
            } else if (!incr(a)) {
                goto ng;
            }
            b = a;
        }
        r = m;
        continue;
        ng:
        l = m;
    }
    writeln(r+1);
}

/*

5
2 3 2 1 2

aa
aaa
ab
b
ba

3
3 2 1

3
1 2 3

aaa
ab
b

6
3 2 3 2 3 2

aaa
ab
aba
ba
baa
bb

6
3 2 1 3 2 1

aaa
ab
b
baa
bb
c

6
4 3 2 4 3 2

aaaa
aab
ab
abaa
abb
ba

4
5 3 3 1

aaaaa
aab
aba
b

4
3 2 2 1

aaa
ab
ba
c

*/