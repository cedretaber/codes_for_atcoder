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
    int K; get(K);
    char[] S; get(S);

    if (K == 0) {
        if (S.length == 1) return writeln("impossible");
        return writeln(S == S.dup.reverse() ? 1 : 0);
    }

    char[][40] ms;
    char[] ls;
    char[][] cs;
    bool solve(int k, char[] s, bool rev) {
        if (s.empty) return false;
        if (k == 0) {
            if (s.length == 1) return false;
            if (rev) s.reverse();
            cs ~= s;
        } else if (k == 1 && s.length == 1) {
            ls ~= s;
        } else {
            if (s.length <= 1) return false;
            if (s.length % 2 == 1) ms[k] ~= s[s.length / 2];
            auto m = s.length / 2;
            if (!solve(k - 1, s[0..m], rev)) return false;
            if (s.length % 2 == 1) ++m;
            if (m > s.length) return false;
            return solve(k - 1, s[m..$], !rev);
        }
        return true;
    }
    if (!solve(K, S, false)) return writeln("impossible");

    int res;
    foreach (mm; ms) if (!mm.empty) {
        int[26] cnt;
        int all;
        foreach (c; mm) {
            ++all;
            ++cnt[c - 'a'];
        }
        res += all - cnt[].maxElement();
    }

    if (!ls.empty) {
        int[26] cnt;
        int all;
        foreach (c; ls) {
            ++all;
            ++cnt[c - 'a'];
        }
        return writeln(res + all - cnt[].maxElement());
    }

    char[] rs;
    int max_sn = -1, targ_i = -1, snd_c;
    foreach (i; 0..cs[0].length) {
        int[26] cnt;
        foreach (cc; cs) ++cnt[cc[i] - 'a'];
        int n = -1, max_cnt = -1;
        foreach (j, cn; cnt) if (cn >= max_cnt) {
            if (n != -1 && max_cnt > max_sn) {
                max_sn = max_cnt;
                targ_i = i.to!int;
                snd_c = j.to!int;
            }
            n = j.to!int;
            max_cnt = cn;
        }
        rs ~= cast(char)(n + 'a');
    }
    if (rs == rs.dup.reverse()) {
        if (max_sn != -1) {
            rs[targ_i] = cast(char)(snd_c + 'a');
        } else {
            rs[0] = rs[0] == 'z' ? 'a' : cast(char)(rs[0] + 1);
        }
    }
    foreach (cc; cs) foreach (i; 0..rs.length) if (cc[i] != rs[i]) ++res;
    writeln(res);
}
