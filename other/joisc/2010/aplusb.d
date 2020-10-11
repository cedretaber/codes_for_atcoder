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

alias D = Tuple!(int, "d", long, "l");

void main()
{
    int N, M;
    SList!D as, bs, rs;

    get(N);
    foreach (_; 0..N) {
        D d; get(d);
        as.insert(d);
    }

    get(M);
    foreach (_; 0..M) {
        D d; get(d);
        bs.insert(d);
    }

    bool c;
    int cnt;
    for (;;) {
        ++cnt;
        if (as.empty && bs.empty) {
            if (c) rs.insert(D(1, 1));
            break;
        } else if (as.empty || bs.empty) {
            D r;
            if (as.empty) {
                r = bs.front;
                bs.removeFront();
            } else {
                r = as.front;
                as.removeFront();
            }
            if (c) {
                c = false;
                if (r.d == 9) {
                    rs.insert(D(0, r.l));
                    c = true;
                } else {
                    rs.insert(D(r.d + 1, 1));
                    if (r.l > 1) rs.insert(D(r.d, r.l - 1));
                }
            } else {
                rs.insert(r);
            }
            continue;
        }

        auto a = as.front;
        as.removeFront();
        auto b = bs.front;
        bs.removeFront();

        if (a.l > b.l) {
            as.insert(D(a.d, a.l - b.l));
        } else if (a.l < b.l) {
            bs.insert(D(b.d, b.l - a.l));
        }
        auto l = min(a.l, b.l);
        auto r = a.d + b.d;
        if (c) {
            c = false;
            if (r > 9) {
                rs.insert(D(r%10 + 1, l));
                c = true;
            } else if (r == 9) {
                rs.insert(D(0, l));
                c = true;
            } else {
                rs.insert(D(r+1, 1));
                if (l > 1) rs.insert(D(r, l-1));
            }
        } else {
            if (r > 9) {
                rs.insert(D(r%10, 1));
                if (l > 1) rs.insert(D(r%10 + 1, l-1));
                c = true;
            } else {
                rs.insert(D(r, l));
            }
        }
    }

    int[] ps = [0];
    ps.reserve(cnt);
    long[] pl = [0];
    pl.reserve(cnt);
    while (!rs.empty) {
        auto r = rs.front;
        rs.removeFront();
        if (ps[$-1] == r.d) {
            pl[$-1] += r.l;
        } else {
            ps ~= r.d;
            pl ~= r.l;
        }
    }
    writeln(ps.length-1);
    foreach (i; 1..ps.length) writeln(ps[i], " ", pl[i]);
}