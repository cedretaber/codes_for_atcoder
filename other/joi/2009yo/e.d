import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

struct Deck
{
    class Card
    {
        int top, bottom, count;
        Card prev, next;
        
        this(int top, int bottom) {
            this.top = top;
            this.bottom = bottom;
            count = bottom - top + 1;
        }

        Card[] separate_at(int i) {
            i += top;
            auto a = new Card(top, i);
            auto b = new Card(i+1, bottom);
            a.next = b;
            b.prev = a;
            return [a, b];
        }

        int count_up(int t, int b, int r) {
            t += top;
            b += top;
            auto c = b - t + 1;
            if (t > r) return 0;
            if (b <= r) return c;
            return r - t + 1;
        }

        override @property
        string toString() {
            return "Card(" ~ top.to!string ~ ".." ~ bottom.to!string ~ ", " ~ count.to!string ~ ")";
        }
    }

    Card card;

    this(int N) {
        this.card = new Card(1, N);
    }

    void shuffle(int x, int y) {
        Card a_top, a_bottom, b_top, b_bottom, c_top, c_bottom;
        auto pos = 1;
        void divide(int i, ref Card top, ref Card bottom) {
            for (;;) {
                auto end = pos + card.count - 1;
                if (pos <= i && i <= end) {
                    if (pos != end) {
                        auto cd = card.separate_at(i - pos);
                        auto c = cd[0];
                        auto d = cd[1];
                        if (card.prev) {
                            card.prev.next = c;
                            c.prev = card.prev;
                        }
                        if (card.next) {
                            card.next.prev = d;
                            d.next = card.next;
                        }
                        if (top == card) top = c;
                        card = c;
                    }
                    bottom = card;
                    pos += card.count;
                    card = card.next;
                    return;
                }
                pos += card.count;
                card = card.next;
            }
        }
        a_top = card;
        divide(x, a_top, a_bottom);
        b_top = card;
        divide(y, b_top, b_bottom);
        c_top = card;
        while (card) {
            c_bottom = card;
            card = card.next;
        }

        card = c_top;
        c_top.prev = null;
        c_bottom.next = b_top;
        b_top.prev = c_bottom;
        b_bottom.next = a_top;
        a_top.prev = b_bottom;
        a_bottom.next = null;
    }

    int count(int p, int q, int r) {
        int res, pos = 1;
        while (card) {
            auto end = pos + card.count - 1;
            auto t = max(pos, p);
            auto b = min(end, q);
            if (t <= b) res += card.count_up(t - pos, b - pos, r);
            pos += card.count;
            card = card.next;
        }
        return res;
    }

    @property
    string show() {
        auto c = card;
        string res = "Deck[";
        while (card) {
            res ~= card.to!string ~ ",";
            card = card.next;
        }
        res ~= "]";
        card = c;
        return res;
    }
}

void main()
{
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto pqr = readln.split.to!(int[]);
    auto P = pqr[0];
    auto Q = pqr[1];
    auto R = pqr[2];

    auto deck = Deck(N);
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        deck.shuffle(xy[0], xy[1]);
    }
    writeln(deck.count(P, Q, R));
}