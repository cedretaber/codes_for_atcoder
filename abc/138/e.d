import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

template bsearch(alias fun) {

    import std.functional: unaryFun;
    alias f = unaryFun!fun;

    int bsearch(T)(T[] arr) {
        if (arr.empty) return -1;

        if (!f(arr[0])) return -1;

        if (f(arr[$-1])) return arr.length.to!int - 1;

        int l, r = arr.length.to!int - 1;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (f(arr[m])) {
                l = m;
            } else {
                r = m;
            }
        }
        return l;
    }
}

size_t[][26] D;

void main()
{
    auto s = readln.chomp.to!(char[]);
    auto t = readln.chomp.to!(char[]);

    foreach (i, c; s) {
        D[c - 'a'] ~= i;
    }

    ulong cnt;
    size_t p;
    bool first = true;
    foreach (c; t) {
        auto d = D[c - 'a'];

        if (d.empty) {
            writeln(-1);
            return;
        }

        if (first) {
            first = false;
            if (d[0] == 0) {
                continue;
            }
        }

        if (d[$-1] <= p) {
            p = d[0];
            ++cnt;
            continue;
        } else if (d[0] > p) {
            p = d[0];
            continue;
        }

        auto l = bsearch!(i => i <= p)(d);
        p = d[l+1];
    }
    writeln(s.length * cnt + p + 1);
}