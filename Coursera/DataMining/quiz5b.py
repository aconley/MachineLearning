import numpy as np

# Points and centroids are just tuples

class Cluster:
    def __init__(self, centroid):
        self.centroid = centroid
        self.points = [centroid]

    def adjust_centroid(self):
        self.centroid = [np.mean([x[0] for x in self.points]),
                         np.mean([x[1] for x in self.points])]

    def __str__(self):
        str = "[Cluster] centroid : " + self.centroid.__str__() + "; points : "
        if len(self.points) > 0:
            str += ", ".join(["({0:0.2f}, {1:0.2f})".format(*k)
                              for k in self.points])
        return str


def distancesq(a, b):
    return (a[0] - b[0])**2 + (a[1] - b[1])**2


def k_means(clusters, points):
    # Assign each point to cluster
    for point in points:
        best_distance = np.inf
        best_cluster = None
        for cluster in clusters:
            cdist = distancesq(point, cluster.centroid)
            if cdist < best_distance:
                best_distance = cdist
                best_cluster = cluster
        best_cluster.points.append(point)

    # Adjust centroids
    for cluster in clusters:
        cluster.adjust_centroid()

    # reassign each point
    for cluster in clusters:
        for point in cluster.points:
            # find the centroid to which point is closest
            best_distance = distancesq(point, c.centroid)
            best_cluster = cluster
            for c in clusters:
                cdist = distance(point, c.centroid)
                if cdost < best_distance:
                    best_distance = cdist
                    best_cluster = c
            if not best_cluster is cluster:
                print("Point {0:0.2f}, {1:0.2f} is reassigned.".format(*point))


def question1():
    clusters = [Cluster((25, 125)), Cluster((44, 105)),
                Cluster((29, 97)), Cluster((35, 63)),
                Cluster((55, 63)), Cluster((42, 57)),
                Cluster((23, 40)), Cluster((64, 37)),
                Cluster((33, 22)), Cluster((55, 20))]
    points = [(28, 145), (65, 140), (50, 130), (38, 115), (55, 118), (50, 90),
              (43, 83), (63, 88), (50, 60), (50, 30)]
    k_means()

def distsq_to_box(p, box_ul, box_lr):
    return [(p[0]-box_ul[0])**2 + (p[1]-box_ul[1])**2,
            (p[0]-box_ul[0])**2 + (p[1]-box_lr[1])**2,
            (p[0]-box_lr[0])**2 + (p[1]-box_ul[1])**2,
            (p[0]-box_lr[0])**2 + (p[1]-box_lr[1])**2]

    
def good_cluster(p1, p2, yellow, blue):
    # The idea is that the farthest point in yellow must be closer
    # than the nearest point in blue to p1, and similarly for p2 with
    # the colors flipped

    dist_p1_yellow = max(distsq_to_box(p1, yellow[0], yellow[1]))
    dist_p2_yellow = min(distsq_to_box(p2, yellow[0], yellow[1]))
    if dist_p1_yellow > dist_p2_yellow:
        return False

    dist_p1_blue = min(distsq_to_box(p1, blue[0], blue[1]))
    dist_p2_blue = max(distsq_to_box(p2, blue[0], blue[1]))
    if dist_p2_blue > dist_p1_blue:
        return False

    return True
    

def question2():
    point1 = (5.0, 10.0)
    point2 = (20.0, 5.0)

    print("Case 1:", good_cluster(point1, point2, ((7, 8), (12, 5)),
                                  ((13, 10), (16, 4))))
    print("Case 2:", good_cluster(point1, point2, ((6, 7), (11, 4)),
                                  ((14, 10), (23, 6))))
    print("Case 3:", good_cluster(point1, point2, ((3, 3), (10, 1)),
                                  ((13, 10), (16, 4))))
    print("Case 4:", good_cluster(point1, point2, ((7, 12), (12, 8)),
                                  ((16, 19), (25, 12))))
    
