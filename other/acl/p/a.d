import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

struct Dsu
{
public:
    this(int n)
    {
        _n = n, parent_or_size = new int[](n);
        parent_or_size[] = -1;
    }

    int merge(int a, int b)
    {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        int x = leader(a), y = leader(b);
        if (x == y)
            return x;
        if (-parent_or_size[x] < -parent_or_size[y])
        {
            auto tmp = x;
            x = y;
            y = tmp;
        }
        parent_or_size[x] += parent_or_size[y];
        parent_or_size[y] = x;
        return x;
    }

    bool same(int a, int b)
    {
        assert(0 <= a && a < _n);
        assert(0 <= b && b < _n);
        return leader(a) == leader(b);
    }

    int leader(int a)
    {
        assert(0 <= a && a < _n);
        if (parent_or_size[a] < 0)
            return a;
        return parent_or_size[a] = leader(parent_or_size[a]);
    }

    int size(int a)
    {
        assert(0 <= a && a < _n);
        return -parent_or_size[leader(a)];
    }

    int[][] groups()
    {
        auto leader_buf = new int[](_n), group_size = new int[](_n);
        foreach (i; 0 .. _n)
        {
            leader_buf[i] = leader(i);
            group_size[leader_buf[i]]++;
        }
        auto result = new int[][](_n);
        foreach (i; 0 .. _n)
            result[i].reserve(group_size[i]);
        foreach (i; 0 .. _n)
            result[leader_buf[i]] ~= i;
        int[][] filtered;
        foreach (r; result)
            if (r.length != 0)
                filtered ~= r;
        return filtered;
    }

private:
    int _n;
    int[] parent_or_size;
}

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto dsu = Dsu(N);
    while (Q--) {
        auto tuv = readln.split.to!(int[]);
        auto t = tuv[0];
        auto u = tuv[1];
        auto v = tuv[2];
        if (t == 0) {
            dsu.merge(u, v);
        } else {
            writeln(dsu.same(u, v) ? 1 : 0);
        }
    }
}