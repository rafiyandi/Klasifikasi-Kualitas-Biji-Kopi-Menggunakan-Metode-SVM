import pandas as pd
import numpy as np
from sklearn import svm
from sklearn.svm import SVC
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
import plotly.express as px  # for data visualization
import plotly.graph_objects as go  # for data visualization


class SVMM:

    def fitting(self, X, y, C, gamma):
        # Create training and testing samples
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=0.2, random_state=0)

        # Fit the model
        # Note, available kernels: {‘linear’, ‘poly’, ‘rbf’, ‘sigmoid’, ‘precomputed’}, default=’rbf’
        model = SVC(kernel='rbf', probability=True, C=C, gamma=gamma)
        clf = model.fit(X_train, y_train)

        # Predict class labels on training data
        pred_labels_tr = model.predict(X_train)
        # Predict class labels on a test data
        pred_labels_te = model.predict(X_test)

        # Use score method to get accuracy of the model
        print('----- Evaluation on Test Data -----')
        score_te = model.score(X_test, y_test)
        print('Accuracy Score: ', score_te)
        # Look at classification report to evaluate the model
        print(classification_report(y_test, pred_labels_te))
        print('--------------------------------------------------------')

        print('----- Evaluation on Training Data -----')
        score_tr = model.score(X_train, y_train)
        print('Accuracy Score: ', score_tr)
        # Look at classification report to evaluate the model
        print(classification_report(y_train, pred_labels_tr))
        print('--------------------------------------------------------')

        # Return relevant data for chart plotting
        return X_train, X_test, y_train, y_test, clf

    def Plot_3D(self, X, X_test, y_test, clf):

        # Specify a size of the mesh to be used
        mesh_size = 5
        margin = 1

        # Create a mesh grid on which we will run our model
        x_min, x_max = X.iloc[:, 2].fillna(X.mean()).min(
        ) - margin, X.iloc[:, 2].fillna(X.mean()).max() + margin
        y_min, y_max = X.iloc[:, 2].fillna(X.mean()).min(
        ) - margin, X.iloc[:, 2].fillna(X.mean()).max() + margin
        xrange = np.arange(x_min, x_max, mesh_size)
        yrange = np.arange(y_min, y_max, mesh_size)
        xx, yy = np.meshgrid(xrange, yrange)

        print(yrange)

        # Calculate predictions on grid
        Z = clf.predict_proba(
            np.c_[xx[:1, :2], yy[:1, :2]])[:, 1]
        Z = Z.reshape(xx[:1, :1].shape)

        # Create a 3D scatter plot with predictions
        fig = px.scatter_3d(x=X_test[0], y=X_test[1], z=y_test,
                            opacity=0.8, color_discrete_sequence=['black'])

        # Set figure title and colors
        fig.update_layout(  # title_text="Scatter 3D Plot with SVM Prediction Surface",
            paper_bgcolor='white',
            scene=dict(xaxis=dict(backgroundcolor='white',
                                  color='black',
                                  gridcolor='#f0f0f0'),
                       yaxis=dict(backgroundcolor='white',
                                  color='black',
                                  gridcolor='#f0f0f0'
                                  ),
                       zaxis=dict(backgroundcolor='lightgrey',
                                  color='black',
                                  gridcolor='#f0f0f0',
                                  )))
        # Update marker size
        fig.update_traces(marker=dict(size=1))

        # Add prediction plane
        fig.add_traces(go.Surface(x=xrange, y=yrange, z=Z, name='SVM Prediction',
                                  colorscale='RdBu', showscale=False,
                                  contours={"z": {"show": True, "start": 0.2, "end": 0.8, "size": 0.05}}))
        fig.show()

    def train(self):
        svma = svm.SVC(decision_function_shape='ovr', kernel='linear')

        kambing_latih = pd.read_csv('csv/latih.csv', header=None)
        kambing_uji = pd.read_csv('csv/uji1.csv', header=None)
        # masukan X dan keluaran Y
        X = kambing_latih.iloc[:, :4]
        Y = kambing_latih.iloc[:, 4]
        X_test = kambing_uji.iloc[1:, :4]

        print(Y)

        # latih classifier
        svma.fit(X, Y)

        # prediksi data test
        Y_pred = svma.predict(X_test)

        # X_train, X_test, y_train, y_test, clf = self.fitting(X, Y, 1, 0.000001)

        # # # Plot 3D chart
        # self.Plot_3D(X, X_test, y_test, clf)

        return Y_pred
